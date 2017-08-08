class StatLine < ApplicationRecord
    belongs_to :user
    belongs_to :team
    belongs_to :game

    belongs_to :game_player

    validates_uniqueness_of :user_id, :scope => :game_id

    validates :position, presence: true
    validates :plus_minus, numericality: { only_integer: true, allow_blank: true }
    validates :shots, numericality: { greater_than_or_equal_to: 0, only_integer: true, allow_blank: true }, allow_nil: true
    validates :fow, numericality: { greater_than_or_equal_to: 0, only_integer: true, allow_blank: true }, allow_nil: true
    validates :fot, numericality: { greater_than_or_equal_to: 0, only_integer: true, allow_blank: true }, allow_nil: true
    validates :hits, numericality: { greater_than_or_equal_to: 0, only_integer: true, allow_blank: true }, allow_nil: true
    validates :shots_against, numericality: { greater_than_or_equal_to: 0, only_integer: true, allow_blank: true }, allow_nil: true
    validates :goals_against, numericality: { greater_than_or_equal_to: 0, only_integer: true, allow_blank: true }, allow_nil: true
end
