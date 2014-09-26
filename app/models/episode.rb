class Episode < ActiveRecord::Base
  has_many :reviews, dependent: :destroy
  has_many :votes, as: :voteable

  validates :title, presence: true
  validates :season, presence: true
  validates :episode_number, presence: true, uniqueness: { scope: :season }

  def vote_score
    votes = Vote.where(voteable_id: id)
    return votes.sum("value") if votes
  end
end
