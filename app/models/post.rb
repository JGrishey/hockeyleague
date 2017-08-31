class Post < ApplicationRecord
    acts_as_votable

    belongs_to :user
    belongs_to :subforum
    has_many :comments, dependent: :destroy

    validates :title, presence: true, length: {minimum: 2, maximum: 100}
    validates :content, presence: true, length: {minimum: 2}


    def most_recent
        self.comments.any? ? self.comments.last : self
    end
end
