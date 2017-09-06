class Team < ApplicationRecord
    validates :name, presence: true

    belongs_to :season
    belongs_to :captain, :class_name => "User", :foreign_key => "captain_id"

    has_many :team_players, dependent: :destroy
    has_many :players, :through => :team_players, :class_name => "User"
    accepts_nested_attributes_for :team_players, allow_destroy: true

    has_many :games
    has_many :game_players, dependent: :destroy

    has_many :stat_lines
    has_many :goals
    has_many :penalties

    has_attached_file :logo
    validates_attachment_content_type :logo, content_type: /\Aimage\/.*\Z/

    def abbreviation
        self.name.split.map(&:first).join
    end

    def games
        Game.where("away_id = ? OR home_id = ?", self.id, self.id)
    end

    def trades
        Movement.where("origin_id = ? OR destination_id = ?", self.id, self.id).group_by{|m| m.trade_id}
    end

    def salary_hit
        self.team_players.inject(0){|sum, e| sum + e.salary}
    end

    def games_played
        self.games.where("final = ?", true)
    end

    def get_logo
        if self.logo.exists?
            self.logo.url
        else
            "nil"
        end
    end

    def standingsData
        wins = 0
        losses = 0
        otl = 0
        gp = self.games_played.count
        gf = 0
        ga = 0
        ppo = 0
        ppg = 0
        pko = 0
        pkk = 0
        shf = 0
        sha = 0
        fow = 0
        fot = 0

        self.games.where(final: true).each do |game|
            if game.home_team == self
                if game.home_goals > game.away_goals
                    wins += 1
                else
                    if game.overtime
                        otl += 1
                    else
                        losses += 1
                    end
                end

                gf += game.home_goals
                ga += game.away_goals
                ppo += game.home_ppo
                ppg += game.home_ppg
                pko += game.away_ppo
                pkk += game.away_ppo - game.away_ppg
                
                game.home_stats.each do |stat|
                    shf += stat.shots
                    fow += stat.fow
                    fot += stat.fot
                end

                game.away_stats.each do |stat|
                    sha += stat.shots
                end
            else
                if game.away_goals > game.home_goals
                    wins += 1
                else
                    if game.overtime
                        otl += 1
                    else
                        losses += 1
                    end
                end

                gf += game.away_goals
                ga += game.home_goals
                ppo += game.away_ppo
                ppg += game.away_ppg
                pko += game.home_ppo
                pkk += game.home_ppo - game.home_ppg
                
                game.away_stats.each do |stat|
                    shf += stat.shots
                    fow += stat.fow
                    fot += stat.fot
                end
                
                game.home_stats.each do |stat|
                    sha += stat.shots
                end
            end
        end

        {
            "league_id": self.season.league.id,
            "season_id": self.season.id,
            "team_id": self.id,
            "wins": wins,
            "losses": losses,
            "otl": otl,
            "pts": wins * 2 + otl,
            "pts%": gp > 0 ? (wins * 2 + otl) / (gp * 2.0) : 0,
            "name": self.name,
            "gp": gp,
            "gf": gf,
            "gfpg": gp > 0 ? gf.to_f / gp : 0,
            "ga": ga,
            "gapg": gp > 0 ? ga.to_f / gp : 0,
            "pp%": ppo > 0 ? ppg.to_f / ppo * 100 : 0,
            "pk%": pko > 0 ? pkk.to_f / pko * 100 : 0,
            "shfpg": gp > 0 ? shf.to_f / gp : 0,
            "shapg": gp > 0 ? sha.to_f / gp : 0,
            "fow%": fot > 0 ? fow.to_f / fot * 100 : 0
        }
    end
end
