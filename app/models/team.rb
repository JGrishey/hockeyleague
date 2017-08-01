class Team < ApplicationRecord
    validates :name, presence: true

    belongs_to :season
    belongs_to :user
    has_many :users
    has_many :games

    def games
        Game.where("away_id = ? OR home_id = ?", self.id, self.id)
    end

    def captain
        self.user
    end
end
