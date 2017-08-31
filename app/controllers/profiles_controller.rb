class ProfilesController < ApplicationController

    before_action :authenticate_user!
    before_action :set_user
    before_action :owned_profile, only: [:edit, :update]

    def show
        @leagues = @user.getLeagues
        @stats = []
        @current_stats = []
        @user.seasons.each do |season|
            season_stats = @user.getSeasonStats(season)
            @stats.push(season_stats)
            if season.current
                @current_stats.push(season_stats)
            end
        end

        @career_stats = []
        @leagues.each do |league|
            l = @stats.select {|s| s[:league_id] == league.id }
            games_played = l.inject(0){ |sum, e| sum + e[:games_played] }
            goals = l.inject(0){ |sum, e| sum + e[:goals] }
            assists = l.inject(0){ |sum, e| sum + e[:assists] }
            points = l.inject(0){ |sum, e| sum + e[:points] }
            plus_minus = l.inject(0){ |sum, e| sum + e[:"plus-minus"] }
            shots = l.inject(0){ |sum, e| sum + e[:shots] }
            pim = l.inject(0){ |sum, e| sum + e[:pim] }
            ppg = l.inject(0){ |sum, e| sum + e[:ppg] }
            ppp = l.inject(0){ |sum, e| sum + e[:ppp] }
            shg = l.inject(0){ |sum, e| sum + e[:shg] }
            shp = l.inject(0){ |sum, e| sum + e[:shp] }
            shper = shots > 0 ? goals / shots.to_f * 100 : 0
            pper = games_played > 0 ? points / games_played.to_f : 0
            fow = l.inject(0){ |sum, e| sum + e[:fow] }
            fot = l.inject(0){ |sum, e| sum + e[:fot] }
            shots_against = l.inject(0){ |sum, e| sum + e[:shots_against] }
            goals_against = l.inject(0){ |sum, e| sum + e[:goals_against] }
            goalie_games = l.inject(0){ |sum, e| sum + e[:goalie_games] }
            wins = l.inject(0){ |sum, e| sum + e[:wins] }
            losses = l.inject(0){ |sum, e| sum + e[:losses] }
            otl = l.inject(0){ |sum, e| sum + e[:otl] }
            shutouts = l.inject(0){ |sum, e| sum + e[:shutouts] }

            @career_stats.push(
                {
                    'league': league.name,
                    'games_played': games_played,
                    'goals': goals,
                    'assists': assists,
                    'points': points,
                    'plus-minus': plus_minus,
                    'shots': shots,
                    'pim': pim,
                    'ppg': ppg,
                    'ppp': ppp,
                    'shg': shg,
                    'shp': shp,
                    'sh%': shper,
                    'p/gp': pper,
                    'fow': fow,
                    'fot': fot,
                    'fo%': fot > 0 ? fow / fot.to_f * 100 : 0,
                    'sa': shots_against,
                    'ga': goals_against,
                    'goalie_gp': goalie_games,
                    'sv%': shots_against > 0 ? (shots_against - goals_against) / shots_against.to_f : 0,
                    'gaa': goalie_games > 0 ? goals_against / goalie_games.to_f : 0,
                    'wins': wins,
                    'losses': losses,
                    'otl': otl,
                    'shutouts': shutouts,
                }
            )
        end

        recent_games = @user.recent_games + @user.recent_goalie_games
        @game_data = []

        recent_games.each do |s|
            scoring = s.game.get_line(@user)
            @game_data.push(
                {
                    'league': s.game.season.league.name,
                    'league_id': s.game.season.league.id,
                    'season': s.game.season.title,
                    'season_id': s.game.season.id,
                    'date': s.game.date.strftime("%^b %d"),
                    'away': s.game.away_team.abbreviation,
                    'away_id': s.game.away_team.id,
                    'away_goals': s.game.away_goals.count,
                    'home': s.game.home_team.abbreviation,
                    'home_id': s.game.home_team.id,
                    'home_goals': s.game.home_goals.count,
                    'game_id': s.game.id,
                    'position': s.position,
                    'goals': scoring[:g],
                    'assists': scoring[:a],
                    'points': scoring[:p],
                    'pim': scoring[:pim],
                    'hits': s.hits,
                    'plus-minus': s["plus-minus"],
                    'shots': s.shots,
                    'shots_against': s.shots_against,
                    'goals_against': s.goals_against,
                    'sv%': s.shots_against > 0 ? ((s.shots_against - s.goals_against.to_f) / s.shots_against) : 0,
                }
            )
        end
    end

    def edit
    end

    def update
        if @user.update(profile_params)
            flash[:success] = 'Your profile has been updated.'
            redirect_to profile_path(@user.user_name)
        else
            @user.errors.full_messages
            flash[:error] = @user.errors.full_messages
            render :edit
        end
    end

    private

    def profile_params
        params.require(:user).permit(:born, :birthplace, :height, :weight, :banner, :avatar)
    end

    def owned_profile
        unless current_user == @user
            flash[:alert] = "That profile doesn't belong to you!"
            redirect_to root_path
        end
    end

    def set_user
        @user = User.find_by(user_name: params[:user_name])
    end

end