class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :episode

  has_many :votes, as: :voteable

  validates :body,
    presence: true,
    length: { minimum: 50 }
  validates :user, presence: true
  validates :episode, presence: true
end
