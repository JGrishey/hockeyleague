class Signup < ApplicationRecord
    belongs_to :season
    belongs_to :player, :class_name => "User", :foreign_key => "user_id"

    validates_uniqueness_of :user_id, :scope => :season_id
end
