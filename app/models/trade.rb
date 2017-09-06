class Trade < ApplicationRecord
    belongs_to :season

    has_many :movements, dependent: :destroy
    accepts_nested_attributes_for :movements, allow_destroy: true
end
