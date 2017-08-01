class User < ApplicationRecord
    
    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable and :omniauthable
    devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable
    
    validates :email, presence: true
    validates :user_name, presence: true, length: { minimum: 3, maximum: 15 }

    has_many :posts, dependent: :destroy
    has_many :comments, dependent: :destroy
    has_many :messages, dependent: :destroy

    has_many :teams
    belongs_to :team

    has_attached_file :avatar
    validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

end
