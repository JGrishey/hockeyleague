class SeasonsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_league
    before_action :set_season, only: [:show, :destroy, :upload, :process_file, :standings, :players, :leaders, :schedule]
    

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
        @season = @league.seasons.find(params[:id])
    end

    def update
        @season = @league.seasons.find(params[:id])
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
            @data.push(team.standingsData)
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
            temp_team = @season.teams.build(name: team, captain_id: current_user.id)
            temp_team.save
        end

        data["games"].each do |game|
           temp_game = @season.games.build(away_id: @season.teams.find_by(name: game["away"]).id, home_id: @season.teams.find_by(name: game["home"]).id, date: DateTime.strptime(game["date"], "%m-%d-%Y %I:%M %p"))
           temp_game.save
        end

        redirect_to league_season_path(@league, @season)
    end

    def standings
        @data = []
        @season.teams.each do |team|
            @data.push(team.standingsData)
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
    
    private

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