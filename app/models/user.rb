class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  # User has many followers
  has_may :follower_follows, class_name: "Follow", foreign_key: "follower_id", dependent: :destroy
  has_many :followers, through: :follower_follows, source: :follower

  # User has many followed users
  has_many :followed_follows, class_name: "Follow", foreign_key: "followed_id", dependent: :destroy
  has_many :followee, through: :followed_follows, source: :followed

  after_create :send_welcome_email

  private
      def send_welcome_email
        UserMailer.welcome_email(self).deliver_now
      end
end
