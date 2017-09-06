class Season < ApplicationRecord
    validates :title, presence: true
    
    has_many :teams, dependent: :destroy
    has_many :games, dependent: :destroy
    belongs_to :league

    has_many :team_players, through: :teams

    has_many :trades

    has_many :signups, dependent: :destroy
    has_many :players, :through => :signups, :class_name => "User"
end
