class Subforum < ApplicationRecord

    has_many :posts, dependent: :destroy

    validates :title, presence: true, length: {minimum: 2, maximum: 100}

end
