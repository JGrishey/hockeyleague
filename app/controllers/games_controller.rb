class GamesController < ApplicationController
    before_action :authenticate_user!
    before_action :set_season
    before_action :set_game, except: [:index, :new, :create]

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
            redirect_to league_season_game_path(@season.league, @season, @game)
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
            redirect_to league_season_game_path(@season.league, @season, @game)
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
        @game.home_goals.build
        @game.home_penalties.build
    end

    def enter_away_stats
        @game.away_goals.build
        @game.away_penalties.build
    end

    def process_home_stats
        @game.update_attributes(params.require(:game).permit(
            :overtime,
            :home_toa_minutes,
            :home_toa_seconds,
            :home_ppg,
            :home_ppo,
            goals_attributes: [:id, :team_id, :scorer_id, :primary_id, :secondary_id, :time_scored, :_destroy],
            penalties_attributes: [:id, :team_id, :user_id, :duration, :_destroy],
            game_players_attributes: [:id, stat_line_attributes: [:game_player_id, :game_id, :team_id, :user_id, :id, :position, :plus_minus, :shots, :hits, :fow, :fot, :shots_against, :goals_against]]
        ))
        puts @game.errors.inspect
        redirect_to league_season_game_path(@season.league, @season, @game)
    end

    def process_away_stats
        @game.update_attributes(params.require(:game).permit(
            :overtime,
            :away_toa_minutes,
            :away_toa_seconds,
            :away_ppg,
            :away_ppo,
            goals_attributes: [:id, :team_id, :scorer_id, :primary_id, :secondary_id, :time_scored, :_destroy],
            penalties_attributes: [:id, :team_id, :user_id, :duration, :_destroy],
            stat_lines_attributes: [:id, :team_id, :position, :user_id, :plus_minus, :shots, :hits, :fow, :fot, :shots_against, :goals_against, :_destroy]
        ))
        puts @game.errors.inspect
        redirect_to league_season_game_path(@season.league, @season, @game)
    end

    def submit_home_players
    end

    def submit_away_players
    end

    def add_players
        @game.update_attributes(params.require(:game).permit(game_players_attributes: [:id, :team_id, :position, :user_id, :_destroy]))

        redirect_to league_season_game_path(@season.league, @season, @game)
    end

    def make_final
        @game.update_attributes(final: true)
        redirect_to league_season_game_path(@season.league, @season, @game)
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