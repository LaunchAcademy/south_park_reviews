class Episode < ActiveRecord::Base
  has_many :reviews, dependent: :destroy
  has_many :votes, as: :voteable

  validates :title, presence: true
  validates :season, presence: true, uniqueness: true
  validates :episode_number, presence: true, uniqueness: true

  def vote_score
    votes = Vote.where(voteable_id: id)
    if votes
      votes.sum("value")
    else
      0
    end
  end
end
