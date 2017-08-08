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

    def games
        Game.where("away_id = ? OR home_id = ?", self.id, self.id)
    end

    def record
        wins = 0
        losses = 0
        otl = 0

        self.games.where(final: true).each do |game|
            if game.home_team == self
                if game.home_goals.count > game.away_goals.count
                    wins += 1
                else
                    if game.overtime
                        otl += 1
                    else
                        losses += 1
                    end
                end
            else
                if game.away_goals.count > game.home_goals.count
                    wins += 1
                else
                    if game.overtime
                        otl += 1
                    else
                        losses += 1
                    end
                end
            end
        end

        {"wins": wins, "losses": losses, "otl": otl}
    end
end
