class GamesController < ApplicationController
    before_action :authenticate_user!
    before_action :set_season
    before_action :set_game, except: [:index, :new, :create]

    def index
        @games = @season.games.order('date ASC')
    end

    def new
        if !current_user.stat_admin && !current_user.admin
            redirect_to root_path
            flash[:alert] = "You do not have permission to enter that page."
        end
        @game = @season.games.build
    end

    def create
        if !current_user.admin && !current_user.admin
            redirect_to root_path
            flash[:alert] = "You do not have permission to enter that page."
        end
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
        if !current_user.stat_admin && !current_user.admin
            redirect_to root_path
            flash[:alert] = "You do not have permission to enter that page."
        end
    end

    def update
        if !current_user.admin && !current_user.admin
            redirect_to root_path
            flash[:alert] = "You do not have permission to enter that page."
        end
        if @game.update(game_params)
            flash[:success] = "Your game has been updated!"
            redirect_to league_season_game_path(@season.league, @season, @game)
        else
            flash[:error] = "Your game couldn't be updated. Please check the form."
            render :edit
        end
    end

    def show
        @home_box = []
        @game.home_stats.each do |s|
            @home_box.push({
                'name': s.user.user_name,
                'position': s.position,
                'goals': s.goals,
                'assists': s.assists,
                'points': s.goals + s.assists,
                'pim': s.pim,
                'hits': s.hits,
                'plus_minus': s.plus_minus,
                'shots': s.shots,
                'fow': s.fow,
                'fot': s.fot,
                'shots_against': s.shots_against,
                'goals_against': s.goals_against,
                'sv%': s.shots_against > 0 ? ((s.shots_against - s.goals_against.to_f) / s.shots_against) : 0,
            })
        end

        @away_box = []
        @game.away_stats.each do |s|
            @away_box.push({
                'name': s.user.user_name,
                'position': s.position,
                'goals': s.goals,
                'assists': s.assists,
                'points': s.goals + s.assists,
                'pim': s.pim,
                'hits': s.hits,
                'plus_minus': s.plus_minus,
                'shots': s.shots,
                'fow': s.fow,
                'fot': s.fot,
                'shots_against': s.shots_against,
                'goals_against': s.goals_against,
                'sv%': s.shots_against > 0 ? ((s.shots_against - s.goals_against.to_f) / s.shots_against) : 0,
            })
        end

        @recent_games = @season.games
        .where(date: 1.week.ago..1.week.from_now)
        .order('date ASC')
        .group_by{
            |g| 
                g.date.strftime("%^b %d")
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
        if !current_user.admin
            redirect_to root_path
            flash[:alert] = "You do not have permission to enter that page."
        end
        @game.destroy
        flash[:success] = "Your game has been deleted."
        redirect_to root_path
    end

    def enter_home_stats
        if !current_user.stat_admin && !current_user.admin
            redirect_to root_path
            flash[:alert] = "You do not have permission to enter that page."
        end
    end

    def enter_away_stats
        if !current_user.stat_admin && !current_user.admin
            redirect_to root_path
            flash[:alert] = "You do not have permission to enter that page."
        end
    end

    def process_home_stats
        @game.update_attributes(params.require(:game).permit(
            :overtime,
            :home_toa_minutes,
            :home_toa_seconds,
            :home_ppg,
            :home_ppo,
            game_players_attributes: [:id, stat_line_attributes: [:game_player_id, :game_id, :team_id, :user_id, :id, :position, :plus_minus, :shots, :hits, :fow, :fot, :shots_against, :goals_against, :goals, :assists, :ppg, :shg, :pim]]
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
            game_players_attributes: [:id, stat_line_attributes: [:game_player_id, :game_id, :team_id, :user_id, :id, :position, :plus_minus, :shots, :hits, :fow, :fot, :shots_against, :goals_against, :goals, :assists, :ppg, :shg, :pim]]
        ))
        puts @game.errors.inspect
        redirect_to league_season_game_path(@season.league, @season, @game)
    end

    def submit_home_players
        if !current_user.stat_admin && !current_user.admin
            redirect_to root_path
            flash[:alert] = "You do not have permission to enter that page."
        end
    end

    def submit_away_players
        if !current_user.stat_admin && !current_user.admin
            redirect_to root_path
            flash[:alert] = "You do not have permission to enter that page."
        end
    end

    def add_players
        @game.update_attributes(params.require(:game).permit(game_players_attributes: [:id, :team_id, :position, :user_id, :_destroy]))

        redirect_to league_season_game_path(@season.league, @season, @game)
    end

    def make_final
        if !current_user.stat_admin && !current_user.admin
            redirect_to root_path
            flash[:alert] = "You do not have permission to enter that page."
        end
        @game.update_attributes(final: true)

        @game.players.each do |player|
            create_notification(
                "Stats have been made available for your game on #{@game.date.strftime("%^b %d at %I:%M %p")}.",
                player,
                league_season_game_path(@season.league, @season, @game)
            )
        end

        redirect_to league_season_game_path(@season.league, @season, @game)
    end

    private

    def create_notification (body, user, src)
        notification = user.notifications.create!(
            body: body,
            src: src
        )
    end

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