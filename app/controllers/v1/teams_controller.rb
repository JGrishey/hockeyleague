module V1
    class TeamsController < ApplicationController
        before_action :set_season
        before_action :set_team, only: [:show, :destroy, :update]

        # GET /leagues/:league_id/seasons/:season_id/teams
        def index
            @teams = @season.teams
            json_response(@teams)
        end

        # POST /leagues/:league_id/seasons/:season_id/teams
        def create
            @team = @season.teams.create!(team_params)
            json_response(@team, :created)
        end

        # PUT /leagues/:league_id/seasons/:season_id/teams/:id
        def update
            @team.update(team_params)
            head :no_content
        end

        # GET /leagues/:league_id/seasons/:season_id/teams/:id
        def show
            json_response(@team)
        end

        # DELETE /leagues/:league_id/seasons/:season_id/teams/:id
        def destroy
            @team.destroy
            head :no_content
        end
        
        private

        def team_params
            params.require(:team).permit(:logo, :name, :season_id, :captain_id, team_players_attributes: [:id, :_destroy, :team_id, :user_id])
        end

        def set_team
            @team = @season.teams.find(params[:id])
        end

        def set_season
            @season = Season.find(params[:season_id])
        end
    end
end
