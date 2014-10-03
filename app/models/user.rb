class User < ActiveRecord::Base
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed
  has_many :reverse_relationships,
    foreign_key: "followed_id",
    class_name: "Relationship",
    dependent: :destroy
  has_many :followers, through: :reverse_relationships, source: :follower
  has_many :reviews, dependent: :destroy
  has_many :votes, dependent: :destroy
  has_many :reviewed_episodes,
    through: :reviews,
    source: :episode
  has_many :voted_episodes,
    through: :votes,
    source: :voteable,
    source_type: 'Episode'
  has_many :favorites
  has_many :episodes, through: :favorites

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

  def following?(other_user)
    relationships.find_by(followed_id: other_user.id)
  end

  def follow!(other_user)
    relationships.create!(followed_id: other_user.id)
  end

  def unfollow!(other_user)
    relationships.find_by(followed_id: other_user.id).destroy
  end

  def favoriting?(episode)
    favorites.find_by(episode_id: episode.id)
  end

  def favorite!(episode)
    favorites.create!(episode_id: episode.id)
  end

  def unfavorite!(episode)
    favorites.find_by(episode_id: episode.id).destroy!
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    login = conditions.delete(:login)
    where(conditions).where(["lower(username) = :value OR lower(email) = :value", { value: login.downcase }]).first
  end
end
