class ProfilesController < ApplicationController

    before_action :authenticate_user!
    before_action :set_user
    before_action :owned_profile, only: [:edit, :update]

    def show
        @leagues = @user.getLeagues
        @stats = []
        @sql_stats = SeasonPlayerStat.all.where(user_id: @user.id).as_json.each do |s|
            season = Season.find(s["season_id"])
            team = @user.getCurrentTeam(season)
            s[:team] = team.name
            s[:team_id] = team.id
            s[:season] = season.title
            s[:league] = season.league.name
            s[:league_id] = season.league.id
        end

        @career_stats = []
        @leagues.each do |league|
            l = @sql_stats.select {|s| s[:league] == league.name }
            games_played = l.inject(0){ |sum, e| sum + e["games_played"] }
            goals = l.inject(0){ |sum, e| sum + e["goals"] }
            assists = l.inject(0){ |sum, e| sum + e["assists"] }
            points = l.inject(0){ |sum, e| sum + e["points"] }
            plus_minus = l.inject(0){ |sum, e| sum + e["plus_minus"] }
            shots = l.inject(0){ |sum, e| sum + e["shots"] }
            pim = l.inject(0){ |sum, e| sum + e["pim"] }
            ppg = l.inject(0){ |sum, e| sum + e["ppg"] }
            shg = l.inject(0){ |sum, e| sum + e["shg"] }
            shper = shots > 0 ? goals / shots.to_f * 100 : 0
            pper = games_played > 0 ? points / games_played.to_f : 0
            fow = l.inject(0){ |sum, e| sum + e["fow"] }
            fot = l.inject(0){ |sum, e| sum + e["fot"] }
            shots_against = l.inject(0){ |sum, e| sum + e["sa"] }
            goals_against = l.inject(0){ |sum, e| sum + e["ga"] }
            goalie_games = l.inject(0){ |sum, e| sum + e["goalie_games"].to_i }
            shutouts = l.inject(0){ |sum, e| sum + e["so"] }

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
                    'shg': shg,
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
                    'shutouts': shutouts,
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

    def post_history
        if !current_user.admin
            redirect_to root_path
            flash[:alert] = "You do not have permission to enter that page."
        end

        @posts_comments = (@user.posts.to_a + @user.comments.to_a).sort_by {|x| x.created_at}
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