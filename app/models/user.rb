class User < ActiveRecord::Base
  has_many :reviews, dependent: :destroy
  has_many :followers
  validates :username,
    uniqueness: { case_sensitive: false },
    presence: true
  ROLES = %w(admin member)

  validates :role, inclusion: { in: ROLES }

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  mount_uploader :profile_image, AvatarUploader

  attr_accessor :login

  def admin?
    role == 'admin'
  end

  def follows?(followed)
    if Follower.find_by(follower_id: id, followed_id: followed.id)
      true
    else
      false
    end
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    login = conditions.delete(:login)
    where(conditions).where(["lower(username) = :value OR lower(email) = :value", { value: login.downcase }]).first
  end
end
