class User < ApplicationRecord
    
    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable and :omniauthable
    devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable
    
    validates :email, presence: true
    validates :user_name, presence: true, length: { minimum: 3, maximum: 15 }

end
