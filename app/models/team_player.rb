class TeamPlayer < ApplicationRecord
    belongs_to :team
    belongs_to :player, :class_name => "User", :foreign_key => "user_id"

    has_many :movements, dependent: :destroy

    validates_uniqueness_of :user_id, :scope => :team_id
end
