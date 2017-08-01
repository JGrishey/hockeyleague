class GamesController < ApplicationController
    before_action :authenticate_user!
    before_action :set_season
    before_action :set_game, only: [:edit, :update, :show, :destroy, :enter_home_stats, :enter_away_stats, :process_stats]

    def index
        @games = @season.games.order('date ASC')
    end

    def new
        @game = @season.games.build
    end

    def create
        @game = @season.games.build(game_params)

        if @game.save
            flash[:success] = "Your game has been created!"
            redirect_to season_game_path(@season, @game)
        else
            flash[:error] = "Your game couldn't be created. Please check the form."
            render :new
        end
    end

    def edit
    end

    def update
        if @game.update(game_params)
            flash[:success] = "Your game has been updated!"
            redirect_to season_game_path(@season, @game)
        else
            flash[:error] = "Your game couldn't be updated. Please check the form."
            render :edit
        end
    end

    def show
    end

    def destroy
        @game.destroy
        flash[:success] = "Your game has been deleted."
        redirect_to root_path
    end

    def enter_home_stats
    end

    def enter_away_stats
    end

    def process_stats
        
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