module V1
    class SeasonsController < ApplicationController
        before_action :set_league
        
        before_action :set_season, except: [:new, :index, :create]

        # GET /leagues/:league_id/seasons
        def index
            @seasons = @league.seasons.order('created_at ASC')
            json_response(@seasons)
        end

        # POST /leagues/:league_id/seasons
        def create
            @season = @league.seasons.create!(season_params)
            json_response(@season, :created)
        end

        # PUT /leagues/:league_id/seasons/:id
        def update
            @season.update(season_params)
            head :no_content
        end

        # GET /leagues/:league_id/seasons/:id
        def show
            @season = @league.seasons.find(params[:id])
            json_response(@season)
        end

        # DELETE /leagues/:league_id/seasons/:id
        def destroy
            @season.destroy
            head :no_content
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
end
