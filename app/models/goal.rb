class Goal < ApplicationRecord
    belongs_to :team
    belongs_to :game
    
    belongs_to :scorer, class_name: "User", foreign_key: "scorer_id", optional: true
    belongs_to :primary, class_name: "User", foreign_key: "primary_id", optional: true
    belongs_to :secondary, class_name: "User", foreign_key: "secondary_id", optional: true

    validates :scorer_id, numericality: { allow_blank: true }, allow_nil: true
    validates :primary_id, numericality: { allow_blank: true }, allow_nil: true
    validates :secondary_id, numericality: { allow_blank: true }, allow_nil: true

    validates :time_scored, presence: true
end
