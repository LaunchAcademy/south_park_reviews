class User < ActiveRecord::Base
  has_many :reviews, dependent: :destroy
  has_many :followers, dependent: :destroy
  has_many :votes, dependent: :destroy
  has_many :reviewed_episodes,
    through: :reviews,
    source: :episode
  has_many :voted_episodes,
    through: :votes,
    source: :voteable,
    source_type: 'Episode'

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
    if Follower.find_by(follower: id, user_id: followed.id)
      true
    else
      false
    end
  end

  def is_following
    #f = Follower.all; f.user not working.  Don't know why.  Must do it the hard way (please help).
    followers = []
    temp = Follower.where(follower: id)
    temp.each do |t|
      followers << t.user
    end
    followers
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    login = conditions.delete(:login)
    where(conditions).where(["lower(username) = :value OR lower(email) = :value", { value: login.downcase }]).first
  end
end
