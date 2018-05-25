class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :posts, dependent: :destroy
  
  validates :name, presence: true
  
  after_create :default_user
  def default_user
    self.add_role(:newuser) if self.roles.blank?
  end
  
  # can use 'current_user.admin?' => true/false
  def admin?
    self.roles == 'admin'
  end
  
end