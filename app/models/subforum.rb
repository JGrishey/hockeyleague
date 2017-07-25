class Subforum < ApplicationRecord

    has_many :posts

    validates :title, presence: true, length: {minimum: 2, maximum: 100}

end
