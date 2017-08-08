class Penalty < ApplicationRecord
    belongs_to :game
    belongs_to :team
    belongs_to :user, optional: true

    validates :duration, presence: true
end
