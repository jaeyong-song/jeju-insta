class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :posts, dependent: :destroy
  
  # 좋아요 기능
  has_many :likes
  has_many :liked_posts, through: :likes, source: :post
  
  has_many :followee_follows, foreign_key: :follower_id, class_name: "Follow"
  has_many :followees, through: :followee_follows, source: :followee
  
  has_many :follower_follows, foreign_key: :followee_id, class_name: "Follow"
  has_many :followers, through: :follower_follows, source: :follower
  
  validates :name, presence: true
  
  after_create :default_user
  def default_user
    self.add_role(:newuser) if self.roles.blank?
  end
  
  # # can use 'current_user.admin?' => true/false
  # def admin?
  #   self.roles == 'admin'
  # end
  
  def toggle_follow(user)
    if self.followers.include?(user)
      self.followers.delete(user)
    else
      self.followers << user
    end
  end
end