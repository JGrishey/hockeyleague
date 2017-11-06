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

    def process_team_stats
        team_image = Base64.strict_encode64(params[:team_stats][:image].read())
        team_stats = JSON.parse(`python ./lib/assets/python/teamparser.py --image #{team_image}`)[0]
        home_toa = team_stats["toa_h"].split(":")
        away_toa = team_stats["toa_a"].split(":")
        home_pp = team_stats["pp_h"].split("/")
        away_pp = team_stats["pp_a"].split("/")
        overtime = params[:team_stats][:overtime]
        @game.update_attributes(
            home_toa_minutes: home_toa[0].to_i,
            home_toa_seconds: home_toa[1].to_i,
            away_toa_minutes: away_toa[0].to_i,
            away_toa_seconds: away_toa[1].to_i,
            home_ppg: home_pp[0].to_i,
            home_ppo: home_pp[1].to_i,
            away_ppg: away_pp[0].to_i,
            away_ppo: away_pp[1].to_i,
            overtime: overtime
        )
        redirect_to enter_home_image_league_season_game_path(@season.league, @season, @game)
    end

    def process_home_image
        skater_image = Base64.strict_encode64(params[:home_images][:skater_image].read())
        goalie_image = Base64.strict_encode64(params[:home_images][:goalie_image].read())

        @skater_stats = JSON.parse(`python ./lib/assets/python/skaterparser.py --image #{skater_image}`)
        @goalie_stats = JSON.parse(`python ./lib/assets/python/goalieparser.py --image #{goalie_image}`)

        redirect_to enter_home_player_names_league_season_game_path(@season.league, @season, @game, skater_stats: @skater_stats, goalie_stats: @goalie_stats)
    end

    def process_away_image
        skater_image = Base64.strict_encode64(params[:away_images][:skater_image].read())
        goalie_image = Base64.strict_encode64(params[:away_images][:goalie_image].read())

        @skater_stats = JSON.parse(`python ./lib/assets/python/skaterparser.py --image #{skater_image}`)
        @goalie_stats = JSON.parse(`python ./lib/assets/python/goalieparser.py --image #{goalie_image}`)

        redirect_to enter_away_player_names_league_season_game_path(@season.league, @season, @game, skater_stats: @skater_stats, goalie_stats: @goalie_stats)
    end

    def enter_home_player_names
        @skater_names = params[:skater_stats].collect{|player| [player["name"]]}
        @goalie_name = params[:goalie_stats].collect{|player| [player["name"]]}
        @skater_stats = params[:skater_stats]
        @goalie_stats = params[:goalie_stats]
    end

    def enter_away_player_names
        @skater_names = params[:skater_stats].collect{|player| [player["name"]]}
        @goalie_name = params[:goalie_stats].collect{|player| [player["name"]]}
        @skater_stats = params[:skater_stats]
        @goalie_stats = params[:goalie_stats]
    end

    def process_home_names
        skater_stats = params[:names][:skater_stats].map{|s| JSON.parse(s)}
        goalie_stats = JSON.parse(params[:names][:goalie_stats])
        params[:names].each do |k, v|
            if k[0] == ":"
                if k[-1] != "m"
                    skater_stats[k[-1].to_i]["player_id"] = v
                    skater_stats[k[-1].to_i]["plus_minus"] = params[:names][":player_#{k[-1]}_pm"]
                    skater_stats[k[-1].to_i]["position"] = params[:names][":player_#{k[-1]}_posm"]
                end
            end
        end

        goalie_stats["player_id"] = params[:names][:goalie]

        skater_stats.each do |skater|
            gp = GamePlayer.new
            gp.game = @game
            gp.player = User.find(skater["player_id"].to_i)
            gp.position = skater["position"]
            gp.team = @game.home_team
            gp.save
            sL = StatLine.new
            sL.game = @game
            sL.team = @game.home_team
            sL.game_player_id = gp.id
            sL.user_id = User.find(skater["player_id"].to_i).id
            sL.position = skater["position"]
            sL.plus_minus = skater["plus_minus"]
            sL.shots = skater["shots"]
            sL.goals = skater["g"]
            sL.assists = skater["a"]
            sL.pim = skater["pim"][0,2].to_i
            sL.ppg = skater["ppg"]
            sL.shg = skater["shg"]
            sL.fow = skater["fow"]
            sL.fot = skater["fot"]
            sL.hits = skater["hits"]
            sL.save
        end

        gp = GamePlayer.new
        gp.game = @game
        gp.player = User.find(goalie_stats["player_id"].to_i)
        gp.position = "G"
        gp.team = @game.home_team
        gp.save
        sL = StatLine.new
        sL.game = @game
        sL.team = @game.home_team
        sL.game_player_id = gp.id
        sL.user_id = User.find(goalie_stats["player_id"].to_i).id
        sL.position = "G"
        sL.shots_against = goalie_stats["sa"]
        sL.goals_against = goalie_stats["ga"]
        sL.assists = goalie_stats["a"]
        sL.goals = goalie_stats["g"]
        sL.save

        redirect_to enter_away_image_league_season_game_path(@season.league, @season, @game)
    end

    def process_away_names
        skater_stats = params[:names][:skater_stats].map{|s| JSON.parse(s)}
        goalie_stats = JSON.parse(params[:names][:goalie_stats])
        params[:names].each do |k, v|
            if k[0] == ":"
                if k[-1] != "m"
                    skater_stats[k[-1].to_i]["player_id"] = v
                    skater_stats[k[-1].to_i]["plus_minus"] = params[:names][":player_#{k[-1]}_pm"]
                    skater_stats[k[-1].to_i]["position"] = params[:names][":player_#{k[-1]}_posm"]
                end
            end
        end

        goalie_stats["player_id"] = params[:names][:goalie]

        skater_stats.each do |skater|
            gp = GamePlayer.new
            gp.game = @game
            gp.player = User.find(skater["player_id"].to_i)
            gp.position = skater["position"]
            gp.team = @game.away_team
            gp.save
            sL = StatLine.new
            sL.game = @game
            sL.team = @game.away_team
            sL.game_player_id = gp.id
            sL.user_id = User.find(skater["player_id"].to_i).id
            sL.position = skater["position"]
            sL.plus_minus = skater["plus_minus"]
            sL.shots = skater["shots"]
            sL.goals = skater["g"]
            sL.assists = skater["a"]
            sL.pim = skater["pim"][0,2].to_i
            sL.ppg = skater["ppg"]
            sL.shg = skater["shg"]
            sL.fow = skater["fow"]
            sL.fot = skater["fot"]
            sL.hits = skater["hits"]
            sL.save
        end

        gp = GamePlayer.new
        gp.game = @game
        gp.player = User.find(goalie_stats["player_id"].to_i)
        gp.position = "G"
        gp.team = @game.away_team
        gp.save
        sL = StatLine.new
        sL.game = @game
        sL.team = @game.away_team
        sL.game_player_id = gp.id
        sL.user_id = User.find(goalie_stats["player_id"].to_i).id
        sL.position = "G"
        sL.shots_against = goalie_stats["sa"]
        sL.goals_against = goalie_stats["ga"]
        sL.assists = goalie_stats["a"]
        sL.goals = goalie_stats["g"]
        sL.save

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