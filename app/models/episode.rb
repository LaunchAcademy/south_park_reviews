class Episode < ActiveRecord::Base
  has_many :reviews, dependent: :destroy
  has_many :upvotes, dependent: :destroy

  validates :title, presence: true
  validates :season, presence: true, uniqueness: true
  validates :episode_number, presence: true, uniqueness: true
end
