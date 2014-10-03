class Favorite < ActiveRecord::Base
  belongs_to :user
  belongs_to :episode

  validates :user, presence: true
  validates :episode, presence: true
end
