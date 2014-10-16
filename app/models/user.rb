class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,:recoverable, :rememberable,
         :trackable, :validatable
  validates :username, :uniqueness => true
  has_many :torrents

  def is_staff?
    self.is_moderator? || self.is_admin?
  end
end
