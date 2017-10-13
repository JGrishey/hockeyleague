class Comment < ApplicationRecord

    acts_as_votable

    self.per_page = 10

    belongs_to :user
    belongs_to :post, touch: true

    validates :content, presence: true, length: {minimum: 2}

end
