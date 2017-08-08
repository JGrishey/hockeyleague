class GamePlayer < ApplicationRecord
    belongs_to :game
    belongs_to :player, :class_name => "User", :foreign_key => "user_id"
    belongs_to :team
    has_one :stat_line, dependent: :destroy
    accepts_nested_attributes_for :stat_line, allow_destroy: true

    validates :position, presence: true

    validates_uniqueness_of :user_id, :scope => :game_id
end
