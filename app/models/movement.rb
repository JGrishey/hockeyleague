class Movement < ApplicationRecord
    belongs_to :trade

    belongs_to :team_player
    
    belongs_to :origin, class_name: "Team", foreign_key: "origin_id"
    belongs_to :destination, class_name: "Team", foreign_key: "destination_id"
end
