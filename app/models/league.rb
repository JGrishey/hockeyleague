class League < ApplicationRecord
    validates :name, presence: true

    has_many :seasons

    def current_season
        self.seasons.find_by(current: true)
    end
end
