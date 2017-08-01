class Game < ApplicationRecord
    belongs_to :away_team, :class_name => "Team", :foreign_key => "away_id"
    belongs_to :home_team, :class_name => "Team", :foreign_key => "home_id"
    belongs_to :season
    has_many :players, :class_name => "User"

    validates :home_toa_minutes, numericality: { greater_than_or_equal_to: 0, only_integer: true }
    validates :home_toa_seconds, numericality: { greater_than_or_equal_to: 0, only_integer: true }
    validates :home_ppg, numericality: { greater_than_or_equal_to: 0, only_integer: true }
    validates :home_ppo, numericality: { greater_than_or_equal_to: 0, only_integer: true }

    validates :away_toa_minutes, numericality: { greater_than_or_equal_to: 0, only_integer: true }
    validates :away_toa_seconds, numericality: { greater_than_or_equal_to: 0, only_integer: true }
    validates :away_ppg, numericality: { greater_than_or_equal_to: 0, only_integer: true }
    validates :away_ppo, numericality: { greater_than_or_equal_to: 0, only_integer: true }

end
