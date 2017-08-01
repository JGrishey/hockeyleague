class TeamsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_team, only: [:show, :destroy]
    before_action :set_season

    def index
        @teams = @season.teams
    end

    def new
        @team = @season.teams.build
    end

    def create
        @team = @season.teams.build(team_params)

        if @team.save
            flash[:success] = "Your team has been created!"
            redirect_to season_team_path(@season, @team)
        else
            flash[:error] = "Your team couldn't be created. Please check the form."
            render :new
        end
    end

    def edit
        @team = @season.teams.find_by(id: params[:id])
    end

    def update
        @team = @season.teams.find_by(id: params[:id])
        if @team.update(team_params)
            flash[:success] = "Your team has been updated!"
            redirect_to season_team_path(@season, @team)
        else
            flash[:error] = "Your team couldn't be updated. Please check the form."
            render :edit
        end
    end

    def show
    end

    def destroy
        @team.destroy
        flash[:success] = "Your team has been deleted."
        redirect_to season_path(@season)
    end
    
    private

    def team_params
        params.require(:team).permit(:name, :season_id, :user_id)
    end

    def set_team
        @team = Team.find(params[:id])
    end

    def set_season
        @season = Season.find(params[:season_id])
    end
end