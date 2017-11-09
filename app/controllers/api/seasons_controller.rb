class Api::SeasonsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_league
    
    before_action :set_season, except: [:new, :index, :create]
    before_action :set_games, except: [:new, :index, :create]
    

    def index
        @seasons = @league.seasons.order('created_at DESC')
    end

    def new
        if !current_user.admin
            redirect_to root_path
            flash[:alert] = "You do not have permission to enter that page."
        end
        @season = @league.seasons.build
    end

    def create
        if !current_user.admin
            redirect_to root_path
            flash[:alert] = "You do not have permission to enter that page."
        end
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
        if !current_user.admin
            redirect_to root_path
            flash[:alert] = "You do not have permission to enter that page."
        end
    end

    def update
        if !current_user.admin
            redirect_to root_path
            flash[:alert] = "You do not have permission to enter that page."
        end
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
        @season.teams.each do |team|
            @data.push(team.standingsData) if team.visibility
        end

        sql_stats = SeasonPlayerStat.all.where(season_id: @season.id).as_json.each do |s|
            u = User.find(s["user_id"])
            s[:name] = u.user_name
            s[:avatar] = u.get_avatar
        end

        @goal_leader = sql_stats.select{|s| s["games_played"] != nil}.max_by{ |p| p["goals"]}
        @assist_leader = sql_stats.select{|s| s["games_played"] != nil}.max_by{ |p| p["assists"]}
        @point_leader = sql_stats.select{|s| s["games_played"] != nil}.max_by{ |p| p["points"]}
        @pim_leader = sql_stats.select{|s| s["games_played"] != nil}.max_by{ |p| p["pim"]}
    end

    def destroy
        if !current_user.admin
            redirect_to root_path
            flash[:alert] = "You do not have permission to enter that page."
        end
        @season.destroy
        flash[:success] = "Your season has been deleted."
        redirect_to root_path
    end

    def upload
        if !current_user.admin
            redirect_to root_path
            flash[:alert] = "You do not have permission to enter that page."
        end
    end

    def process_file
        uploaded_schedule = params[:season][:schedule].read
        data = JSON.parse(uploaded_schedule)

        # Clear existing data
        @season.games.each do |game|
            game.destroy
        end

        data["games"].each do |game|
           temp_game = @season.games.build(away_id: @season.teams.find_by(name: game["away"]).id, home_id: @season.teams.find_by(name: game["home"]).id, date: DateTime.strptime(game["date"], "%m-%d-%Y %I:%M %p"))
           temp_game.save
        end

        redirect_to league_season_path(@league, @season)
    end

    def players
        @sql_stats = SeasonPlayerStat.all.where(season_id: @season.id).as_json.each{|s| s[:name] = User.find(s["user_id"]).user_name}
    end

    def leaders
        sql_stats = SeasonPlayerStat.all.where(season_id: @season.id).as_json.each do |s|
            u = User.find(s["user_id"])
            s[:name] = u.user_name
            s[:avatar] = u.get_avatar
        end

        @goal_leaders = sql_stats.select{|s| s["games_played"] != nil}.sort_by{|s| -s["goals"]}.first(5)
        @assist_leaders = sql_stats.select{|s| s["games_played"] != nil}.sort_by{|s| -s["assists"]}.first(5)
        @point_leaders = sql_stats.select{|s| s["games_played"] != nil}.sort_by{|s| -s["points"]}.first(5)
        @plusminus_leaders = sql_stats.select{|s| s["games_played"] != nil}.sort_by{ |s| -s["plus_minus"]}.first(5)
        @gaa_leaders = sql_stats.select{|s| s["goalie_games"] != nil}.sort_by{|s| s["gaa"]}.first(5)
        @sv_leaders = sql_stats.select{|s| s["goalie_games"] != nil}.sort_by{|s| -s["sv_per"]}.first(5)
        @gp_leaders = sql_stats.select{|s| s["goalie_games"] != nil}.sort_by{|s| -s["goalie_games"]}.first(5)
        @so_leaders = sql_stats.select{|s| s["goalie_games"] != nil}.sort_by{|s| -s["so"]}.first(5)
    end

    def schedule
        @games = @season.games
        .order('date ASC')
        .group_by{
            |g| 
                g.date.strftime("%^a %^b %d")
        }
        .to_a
        .map{ 
            |x| 
                [
                    x[0], 
                    x[1].group_by{|g| g.teams}.to_a
                ]
        }
    end

    def signup
        if current_user.signed_up_for(@season)
            redirect_to root_path
            flash[:alert] = "You already signed up!"
        end
        @signup = Signup.new
    end

    def process_signup
        @signup = Signup.new(params.require(:signup).permit(:season_id, :user_id, :preferred, :veteran, :part_time, :mia, willing: []))
        if @signup.save
            tp = TeamPlayer.new
            tp.team = @season.teams.find_by(name: "Unplaced Players")
            tp.player = @signup.player
            tp.salary = 0
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
        if !current_user.admin && !current_user.captain?(@season) && !current_user.stat_admin
            redirect_to root_path
            flash[:alert] = "You do not have permission to enter that page."
        end
        @transaction = @season.trades.build
        @transaction.movements.build
        @teams = current_user.owned_teams
    end

    def process_transaction
        if !current_user.admin && !current_user.captain?(@season) && !current_user.stat_admin
            redirect_to root_path
            flash[:alert] = "You do not have permission to enter that page."
        end
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
        if !current_user.admin && !current_user.captain?(@season) && !current_user.stat_admin
            redirect_to root_path
            flash[:alert] = "You do not have permission to enter that page."
        end
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

            announcement = ""
            announcement += "<h5>Transaction Announcement!</h5><hr></hr>"

            @trade.movements.group_by{|m| m.destination_id}.each do |key, value|
                names = [] 
                value.each do |v|
                    names.push(v.team_player.player.user_name)
                end
                announcement += "<p class='text-left'>"
                announcement += "<strong>#{@season.teams.find(key).name} </strong>receive: #{names.to_sentence}"
                announcement += "</p>"
            end

            User.find_by(user_name: "Admin").messages.create!(
                body: announcement.html_safe,
                chat_box_id: ChatBox.first.id)

            redirect_to transactions_league_season_path(@league, @season)
        end
    end

    def decline_transaction
        if !current_user.admin && !current_user.captain?(@season) && !current_user.stat_admin
            redirect_to root_path
            flash[:alert] = "You do not have permission to enter that page."
        end

        @trade = @season.trades.find(params[:trade_id])

        @trade.update_attributes(pending: false)

        redirect_to transactions_league_season_path(@league, @season)
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

    def set_games
        @recent_games = @season.games
        .where(date: 1.week.ago..1.week.from_now)
        .order('date ASC')
        .group_by{
            |g| 
                g.date.strftime("%^a %^b %d")
        }
        .to_a
        .map{ 
            |x| 
                [
                    x[0], 
                    x[1].group_by{|g| g.teams}.to_a
                ]
        }
    end
end