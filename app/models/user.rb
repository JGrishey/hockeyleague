class User < ApplicationRecord
    devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable
    include DeviseTokenAuth::Concerns::User
    scope :online, lambda{ where("updated_at > ?", 10.minutes.ago) }

    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable and :omniauthable
    
    
    validates :email, presence: true
    validates :user_name, presence: true, length: { minimum: 3, maximum: 15 }

    has_many :posts, dependent: :destroy
    has_many :comments, dependent: :destroy
    has_many :messages, dependent: :destroy

    has_many :notifications, dependent: :destroy

    has_many :owned_teams, :class_name => "Team", :foreign_key => "captain_id"

    has_many :game_players, dependent: :destroy
    has_many :games, :through => :game_players
    
    has_many :team_players, dependent: :destroy
    has_many :teams, :through => :team_players
    has_many :seasons, :through => :teams

    has_many :signups, dependent: :destroy
    has_many :seasons_signed_up, :through => :signups, :source => :season

    has_many :goals, :class_name => "Goal", :foreign_key => "scorer_id"
    has_many :primary_assists, :class_name => "Goal", :foreign_key => "primary_id"
    has_many :secondary_assists, :class_name => "Goal", :foreign_key => "secondary_id"
    has_many :penalties
    has_many :stat_lines

    has_attached_file :avatar, styles: { :original => "300x300#" }, default_style: :original
    validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

    def online?
        updated_at < 10.minutes.ago
    end

    def remember_me
        true
    end

    def signed_up_for (season)
        self.seasons_signed_up.include?(season)
    end

    def captain? (season)
        self.owned_teams.each do |team|
            if team.season.current && team.season == season
                return true
            end
        end
        return false
    end

    def inSeason (season)
        self.seasons.include?(season)
    end

    def current_seasons
        self.seasons.where("current = ?", true)
    end

    def get_avatar
        if self.avatar.exists?
            self.avatar.url
        else
            "nil"
        end
    end

    def recent_games
        games = []
        self.stat_lines.order('created_at ASC').each do |s|
            if games.length == 5
                break
            elsif s.game.final && s.position != "G"
                games.push(s)
            end
        end
        games
    end

    def recent_goalie_games
        games = []
        self.stat_lines.order('created_at ASC').each do |s|
            if games.length == 5
                break
            elsif s.game.final && s.position == "G"
                games.push(s)
            end
        end
        games
    end

    def getCurrentTeam (season)
        team = nil
        self.team_players.each do |tp|
            if tp.team.season == season
                team = tp.team
            end
        end
        team
    end

    def getCurrentTeamPlayer (season)
        team = nil
        self.team_players.each do |tp|
            if tp.team.season == season
                team = tp
            end
        end
        team
    end

    def getLeagues
        leagues = []
        self.seasons.each do |season|
            if !leagues.include?(season.league)
                leagues.push(season.league)
            end
        end
        leagues
    end

    def getSeasonStats (season)
        goals = 0
        team = self.getCurrentTeam(season)
        assists = 0
        plus_minus = 0
        shg = 0
        ppg = 0
        shp = 0
        ppp = 0
        shots = 0
        fow = 0
        fot = 0
        hits = 0
        wins = 0
        losses = 0
        otl = 0
        shots_against = 0
        goals_against = 0
        pim = 0
        games_played = 0
        goalie_games = 0
        goals_against = 0
        shots_against = 0
        shutouts = 0
        
        self.stat_lines.each do |stats|
            if stats.game.season == season && stats.game.final
                plus_minus += stats.plus_minus if stats.plus_minus
                shots += stats.shots if stats.shots
                fow += stats.fow if stats.fow
                fot += stats.fot if stats.fot
                hits += stats.hits if stats.hits
                shots_against += stats.shots_against if stats.shots_against
                goals_against += stats.goals_against if stats.goals_against
                goals += stats.goals if stats.goals
                assists += stats.assists if stats.assists
                pim += stats.pim if stats.pim
                ppg += stats.ppg if stats.ppg
                shg += stats.shg if stats.shg

                if stats.position === "G"
                    goalie_games += 1

                    if stats.team == stats.game.home_team
                        if stats.game.home_goals > stats.game.away_goals
                            if stats.game.away_goals == 0
                                shutouts += 1
                            end
                            wins += 1
                        elsif stats.game.overtime
                            otl += 1
                        else
                            losses += 1
                        end
                    else
                        if stats.game.away_goals > stats.game.home_goals
                            if stats.game.home_goals == 0
                                shutouts += 1
                            end
                            wins += 1
                        elsif stats.game.overtime
                            otl += 1
                        else
                            losses += 1
                        end
                    end
                else
                    games_played += 1
                end    
            end
        end
        return {
            'name': self.user_name,
            'avatar': self.get_avatar,
            'team': team.abbreviation,
            'team_logo': team.get_logo,
            'team_id': team.id,
            'season': season.title,
            'season_id': season.id,
            'league_id': season.league.id,
            'league': season.league.name,
            'wins': wins,
            'losses': losses,
            'otl': otl,
            'goals': goals,
            'assists': assists,
            'points': goals + assists,
            'plus-minus': plus_minus,
            'pim': pim,
            'p/gp': games_played > 0 ? (goals + assists) / games_played.to_f : 0,
            'ppg': ppg,
            'ppp': ppp,
            'shg': shg,
            'shp': shp,
            'shots': shots,
            'sh%': shots > 0 ? (goals.to_f / shots * 100) : 0,
            'fow': fow,
            'fot': fot,
            'fo%': fot > 0 ? (fow.to_f / fot) * 100 : 0,
            'hits': hits,
            'shots_against': shots_against,
            'goals_against': goals_against,
            'goalie_games': goalie_games,
            'sv%': shots_against > 0 ? ((shots_against - goals_against.to_f) / shots_against) : 0,
            'gaa': goalie_games > 0 ? (goals_against.to_f / goalie_games) : 0,
            'shutouts': shutouts,
            'games_played': games_played
        }
    end
end
