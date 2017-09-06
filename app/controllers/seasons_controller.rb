class SeasonsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_league
    before_action :set_season, except: [:new, :index, :create]
    

    def index
        @seasons = @league.seasons.order('created_at DESC')
    end

    def new
        @season = @league.seasons.build
    end

    def create
        @season = @league.seasons.build(season_params)

        if @season.save
            flash[:success] = "Your season has been created!"
            redirect_to league_season_path(@league, @season)
        else
            flash[:error] = "Your season couldn't be created. Check the form."
            render :new
        end
    end

    def edit
    end

    def update
        if @season.update(season_params)
            flash[:success] = "Your season has been updated!"
            redirect_to league_season_path(@league, @season)
        else
            flash[:error] = "Your season couldn't be updated. Check the form."
            render :edit
        end
    end

    def show
        @data = []
        playerstats = []
        @season.teams.each do |team|
            @data.push(team.standingsData) if team.visibility
            team.players.each do |player|
                playerstats.push(player.getSeasonStats(@season))
            end
        end

        @goal_leader = playerstats.max_by{ |p| p[:games_played] > 0 ? p[:goals] : 0}
        @assist_leader = playerstats.max_by{ |p| p[:games_played] > 0 ? p[:assists] : 0}
        @point_leader = playerstats.max_by{ |p| p[:games_played] > 0 ? p[:points] : 0}
        @pim_leader = playerstats.max_by{ |p| p[:games_played] > 0 ? p[:pim] : 0}
    end

    def destroy
        @season.destroy
        flash[:success] = "Your season has been deleted."
        redirect_to root_path
    end

    def upload
    end

    def process_file
        uploaded_schedule = params[:season][:schedule].read
        data = JSON.parse(uploaded_schedule)

        # Clear existing data
        @season.games.each do |game|
            game.destroy
        end
        @season.teams.each do |team|
            team.destroy
        end


        data["teams"].each do |team|
            temp_team = @season.teams.build(name: team, captain_id: current_user.id, salary_cap: 115)
            temp_team.save
        end

        data["games"].each do |game|
           temp_game = @season.games.build(away_id: @season.teams.find_by(name: game["away"]).id, home_id: @season.teams.find_by(name: game["home"]).id, date: DateTime.strptime(game["date"], "%m-%d-%Y %I:%M %p"))
           temp_game.save
        end

        unplaced_players = @season.teams.build(name: "Unplaced Players", captain_id: current_user.id, visibility: false, salary_cap: 20000)
        unplaced_players.save

        redirect_to league_season_path(@league, @season)
    end

    def standings
        @data = []
        @season.teams.each do |team|
            @data.push(team.standingsData) if team.visibility
        end
    end

    def players
        @data = []
        @season.teams.each do |team|
            team.players.each do |player|
                stats = player.getSeasonStats(@season)
                stats[:games_played] > 0 ? @data.push(stats) : ()
            end
        end
    end

    def leaders
        skaters = []
        goalies = []
        @season.teams.each do |team|
            team.players.each do |player|
                stats = player.getSeasonStats(@season)
                
                if stats[:games_played] > 0
                    skaters.push(stats)
                end

                if stats[:goalie_games] > 0
                    goalies.push(stats)
                end
            end
        end

        @goal_leaders = skaters.sort_by { |s| -s[:goals]}
        @assist_leaders = skaters.sort_by{|s| -s[:assists]}
        @point_leaders = skaters.sort_by{|s| -s[:points]}
        @plusminus_leaders = skaters.sort_by{|s| -s[:"plus-minus"]}
        @gaa_leaders = goalies.sort_by{|s| s[:gaa]}
        @sv_leaders = goalies.sort_by{|s| -s[:"sv%"]}
        @win_leaders = goalies.sort_by{|s| -s[:wins]}
        @so_leaders = goalies.sort_by{|s| -s[:shutouts]}
    end

    def schedule
        @games = @season.games.order('date ASC').group_by{|g| g.date.strftime("%^b %d, %Y")}
    end

    def signup
        @signup = Signup.new
    end

    def process_signup
        @signup = Signup.new(params.require(:signup).permit(:season_id, :user_id, :preferred, :veteran, :part_time, :mia, willing: []))
        if @signup.save
            tp = TeamPlayer.new
            tp.team = @season.teams.find_by(name: "Unplaced Players")
            tp.player = @signup.player
            tp.save
            flash[:success] = "You're signed up!"
            redirect_to league_season_path(@league, @season)
        else
            flash[:error] = "Check the form."
            render :signup
        end
    end

    def signups
        @signups = []
        @season.signups.each do |x|
            @signups.push({
                'name': x.player.user_name,
                'preferred': x.preferred,
                'willing': x.willing.length > 1 ? x.willing.drop(1) : x.willing,
                'mia': x.mia,
                'veteran': x.veteran,
                'part_time': x.part_time,
            })
        end
    end

    def transactions
        @pending_trades = @season.trades.where(pending: true).order('created_at ASC')
        @approved_trades = @season.trades.where(approved: true).order('updated_at DESC')
    end

    def submit_transaction
        @transaction = @season.trades.build
        @transaction.movements.build
        @teams = current_user.owned_teams
    end

    def process_transaction
        @transaction = @season.trades.build(params.require(:trade).permit(
            movements_attributes: [:_destroy, :id, :destination_id, :team_player_id]
        ))
        @transaction.movements.each_with_index do |movement, index|
            movement.origin_id = movement.team_player.team.id
        end

        over = check_trade(@transaction, @season)

        if over
            render :submit_transaction
        else
            @transaction.save
            redirect_to transactions_league_season_path(@league, @season)
        end
    end

    def approve_transaction
        @trade = @season.trades.find(params[:trade_id])

        over = check_trade(@trade, @season)

        if over
            flash[:error] = "This transaction violates the salary cap."
            redirect_to transactions_league_season_path(@league, @season)
        else
            @trade.movements.each do |movement|
                movement.team_player.update_attributes(team_id: movement.destination_id)
                create_notification(
                    "You have been involved in a transaction. Check the transactions page.",
                    movement.team_player.player,
                    transactions_league_season_path(@league, @season)
                )
            end

            @trade.update_attributes(pending: false, approved: true)

            User.find_by(user_name: "Admin").messages.create!(
                body: "A transaction has just been approved in #{@league.name}. Check it out!",
                chat_box_id: ChatBox.first.id)

            redirect_to transactions_league_season_path(@league, @season)
        end
    end
    
    private

    def check_trade (trade, season)
        over = false

        teams = []
        
        trade.movements.each do |m|
            origin = season.teams.find(m.origin_id)
            dest = season.teams.find(m.destination_id)

            if !teams.include?(origin)
                teams.push(origin)
            end

            if !teams.include?(dest)
                teams.push(dest)
            end
        end

        teams = teams.map{|t| {
                "team": t,
                "hit": t.salary_hit,
                "cap": t.salary_cap
            }}

        trade.movements.each do |m|
            origin = season.teams.find(m.origin_id)
            dest = season.teams.find(m.destination_id)

            teams.detect{|t| t[:team] == origin}[:hit] -= TeamPlayer.find(m.team_player_id).salary
            teams.detect{|t| t[:team] == dest}[:hit] += TeamPlayer.find(m.team_player_id).salary
        end

        teams.each do |t|
            if t[:hit] > t[:cap]
                over = true
            end
        end

        over
    end

    def create_notification (body, user, src)
        notification = user.notifications.create!(
            body: body,
            src: src
        )
    end

    def season_params
        params.require(:season).permit(:title)
    end

    def set_season
        @season = @league.seasons.find(params[:id])
    end

    def set_league
        @league = League.find(params[:league_id])
    end
end