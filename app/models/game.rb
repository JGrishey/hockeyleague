class Game < ApplicationRecord
    belongs_to :away_team, :class_name => "Team", :foreign_key => "away_id"
    belongs_to :home_team, :class_name => "Team", :foreign_key => "home_id"
    belongs_to :season
    has_many :users
end
