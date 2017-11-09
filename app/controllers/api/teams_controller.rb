class Api::TeamsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_team, only: [:show, :destroy, :schedule]
    before_action :set_season

    def index
        @teams = @season.teams
    end

    def new
        if !current_user.admin
            redirect_to root_path
            flash[:alert] = "You do not have permission to enter that page."
        end
        @team = @season.teams.build
    end

    def create
        if !current_user.admin
            redirect_to root_path
            flash[:alert] = "You do not have permission to enter that page."
        end
        @team = @season.teams.build(team_params)

        if params[:captain_id]
            if !@team.players.include?(params[:captain_id])
                tp = TeamPlayer.new()
                tp.team = @team
                tp.player = User.find(params[:team][:captain_id].to_i)
                tp.save
            end
        end

        if @team.save
            flash[:success] = "Your team has been created!"
            redirect_to league_season_team_path(@season.league, @season, @team)
        else
            flash[:error] = "Your team couldn't be created. Please check the form."
            render :new
        end
    end

    def edit
        if !current_user.admin && current_user != @team.captain
            redirect_to root_path
            flash[:alert] = "You do not have permission to enter that page."
        end
        @team = @season.teams.find_by(id: params[:id])
    end

    def update
        @team = @season.teams.find_by(id: params[:id])

        if @team.update(team_params)
            flash[:success] = "Your team has been updated!"
            redirect_to league_season_team_path(@season.league, @season, @team)
        else
            flash[:error] = "Your team couldn't be updated. Please check the form."
            render :edit
        end
    end

    def show
        @league = @season.league
        @team_data = @team.standingsData
        @data = []
        @team.players.each do |player|
            @data.push(player.getSeasonStats(@season))
        end
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

    def destroy
        @team.destroy
        flash[:success] = "Your team has been deleted."
        redirect_to league_season_path(@season.league, @season)
    end

    def schedule
        @games = @team.games.order('date ASC').group_by{|g| g.date.strftime("%^b %d, %Y")}
    end
    
    private

    def team_params
        params.require(:team).permit(:logo, :name, :season_id, :captain_id, team_players_attributes: [:id, :_destroy, :team_id, :user_id])
    end

    def set_team
        @team = Team.find(params[:id])
    end

    def set_season
        @season = Season.find(params[:season_id])
    end
end