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

    validates :home_toa_minutes, numericality: { greater_than_or_equal_to: 0, only_integer: true, allow_blank: true }, allow_nil: true
    validates :home_toa_seconds, numericality: { greater_than_or_equal_to: 0, only_integer: true, allow_blank: true }, allow_nil: true
    validates :home_ppg, numericality: { greater_than_or_equal_to: 0, only_integer: true, allow_blank: true }, allow_nil: true
    validates :home_ppo, numericality: { greater_than_or_equal_to: 0, only_integer: true, allow_blank: true }, allow_nil: true

    validates :away_toa_minutes, numericality: { greater_than_or_equal_to: 0, only_integer: true, allow_blank: true }, allow_nil: true
    validates :away_toa_seconds, numericality: { greater_than_or_equal_to: 0, only_integer: true, allow_blank: true }, allow_nil: true
    validates :away_ppg, numericality: { greater_than_or_equal_to: 0, only_integer: true, allow_blank: true }, allow_nil: true
    validates :away_ppo, numericality: { greater_than_or_equal_to: 0, only_integer: true, allow_blank: true }, allow_nil: true

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
