class Season < ApplicationRecord
    validates :title, presence: true
    
    has_many :teams, dependent: :destroy
    has_many :games, dependent: :destroy
    belongs_to :league
end
