class LeaguesController < ApplicationController
    before_action :authenticate_user!
    before_action :set_league, except: [:new, :create, :index]

    def index
        @leagues = League.all.order('name DESC')
    end

    def new
        @league = League.new
    end

    def create
        @league = League.new(league_params)

        if @league.save
            flash[:success] = "Your league has been created!"
            redirect_to @league
        else
            flash[:error] = "Your league couldn't be created. Please check the form."
            render :new
        end
    end

    def edit
    end

    def update
        if @league.update(league_params)
            flash[:success] = "Your league has been updated!"
            redirect_to @league
        else
            flash[:error] = "Your league couldn't be updated. Please check the form."
            render :edit
        end
    end

    def show
        @data = []
        playerstats = []
        @league.current_season.teams.each do |team|
            @data.push(team.standingsData) if team.visibility
            team.players.each do |player|
                playerstats.push(player.getSeasonStats(@league.current_season))
            end
        end

        @goal_leader = playerstats.max_by{ |p| p[:games_played] > 0 ? p[:goals] : 0}
        @assist_leader = playerstats.max_by{ |p| p[:games_played] > 0 ? p[:assists] : 0}
        @point_leader = playerstats.max_by{ |p| p[:games_played] > 0 ? p[:points] : 0}
        @pim_leader = playerstats.max_by{ |p| p[:games_played] > 0 ? p[:pim] : 0}
    end

    def standings
        @data = []
        @season = @league.current_season
        @season.teams.each do |team|
            @data.push(team.standingsData) if team.visibility
        end
    end

    def players
        @data = []
        @season = @league.current_season
        @season.teams.each do |team|
            team.players.each do |player|
                stats = player.getSeasonStats(@season)
                stats[:games_played] > 0 ? @data.push(stats) : ()
            end
        end
    end

    def destroy
        @league.destroy
        flash[:success] = "Your league was deleted."
        redirect_to root_path
    end

    def schedule
        @season = @league.current_season
        @games = @season.games.order('date ASC').group_by{|g| g.date.strftime("%^b %d, %Y")}
    end

    def history
        @season = @league.current_season
    end

    def leaders
        skaters = []
        goalies = []
        @season = @league.current_season
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

    def signups
        @season = @league.current_season
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
        @season = @league.current_season
        @pending_trades = @season.trades.where(pending: true).order('created_at ASC')
        @approved_trades = @season.trades.where(approved: true).order('updated_at DESC')
    end

    private

    def league_params
        params.require(:league).permit(:name)
    end

    def set_league
        @league = League.find(params[:id])
    end
end