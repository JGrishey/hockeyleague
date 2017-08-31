class Game < ApplicationRecord
    belongs_to :away_team, :class_name => "Team", :foreign_key => "away_id"
    belongs_to :home_team, :class_name => "Team", :foreign_key => "home_id"

    belongs_to :season

    has_many :game_players, dependent: :destroy
    has_many :players, :through => :game_players, :class_name => "User"
    accepts_nested_attributes_for :game_players, allow_destroy: true

    has_many :stat_lines, dependent: :destroy
    accepts_nested_attributes_for :stat_lines, allow_destroy: true

    has_many :goals, dependent: :destroy
    accepts_nested_attributes_for :goals, allow_destroy: true

    has_many :penalties, dependent: :destroy
    accepts_nested_attributes_for :penalties, allow_destroy: true

    validates :home_toa_minutes, numericality: { greater_than_or_equal_to: 0, only_integer: true }
    validates :home_toa_seconds, numericality: { greater_than_or_equal_to: 0, only_integer: true }
    validates :home_ppg, numericality: { greater_than_or_equal_to: 0, only_integer: true }
    validates :home_ppo, numericality: { greater_than_or_equal_to: 0, only_integer: true }

    validates :away_toa_minutes, numericality: { greater_than_or_equal_to: 0, only_integer: true }
    validates :away_toa_seconds, numericality: { greater_than_or_equal_to: 0, only_integer: true }
    validates :away_ppg, numericality: { greater_than_or_equal_to: 0, only_integer: true }
    validates :away_ppo, numericality: { greater_than_or_equal_to: 0, only_integer: true }

    def get_line (user)
        goals = 0
        assists = 0
        points = 0
        pim = 0
        self.goals.each do |goal|
            if goal.scorer == user
                goals += 1
                points += 1
            end
            if goal.primary == user || goal.secondary == user
                assists += 1
                points += 1
            end
        end
        self.penalties.each do |penalty|
            if penalty.user == user
                pim += penalty.duration
            end
        end
        {
            'g': goals,
            'a': assists,
            'p': points,
            'pim': pim,
        }
    end

    def home_goals
        self.goals.where(team_id: self.home_team.id)
    end

    def away_goals
        self.goals.where(team_id: self.away_team.id)
    end

    def home_penalties
        self.penalties.where(team_id: self.home_team.id)
    end

    def away_penalties
        self.penalties.where(team_id: self.away_team.id)
    end

    def home_stats
        self.stat_lines.where(team_id: self.home_team.id)
    end

    def away_stats
        self.stat_lines.where(team_id: self.away_team.id)
    end

    def home_players
        self.game_players.where(team_id: self.home_team.id)
    end

    def away_players
        self.game_players.where(team_id: self.away_team.id)
    end
end
