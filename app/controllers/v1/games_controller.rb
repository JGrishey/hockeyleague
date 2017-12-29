module V1
    class GamesController < ApplicationController
        before_action :set_season
        before_action :set_game, except: [:index, :new, :create]

        # GET /leagues/:league_id/seasons/:season_id/games
        def index
            @games = @season.games.order('date ASC')
            json_response(@games)
        end

        # POST /leagues/:league_id/seasons/:season_id/games
        def create
            @game = @season.games.create!(game_params)
            json_response(@game, :created)
        end

        # PUT /leagues/:league_id/seasons/:season_id/games/:id
        def update
            @game.update(game_params)
            head :no_content
        end

        # GET /leagues/:league_id/seasons/:season_id/games/:id
        def show
            json_response(@game)
        end

        # DELETE /leagues/:league_id/seasons/:season_id/games/:id
        def destroy
            if !current_user.admin
                redirect_to root_path
                flash[:alert] = "You do not have permission to enter that page."
            end
            @game.destroy
            flash[:success] = "Your game has been deleted."
            redirect_to root_path
        end

        private

        def game_params
            params.require(:game).permit(:away_id, :home_id, :season_id, :date)
        end

        def set_game
            @game = Game.find(params[:id])
        end

        def set_season
            @season = Season.find(params[:season_id])
        end
    end
end
