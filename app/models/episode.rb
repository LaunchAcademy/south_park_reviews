class Episode < ActiveRecord::Base
  has_many :favorites, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :votes, as: :voteable

  validates :title, presence: true
  validates :season, presence: true
  validates :episode_number, presence: true, uniqueness: { scope: :season }

  def vote_score
    votes.sum(:value)
  end

  def has_upvote_from?(user)
    vote = vote_from(user)
    vote.present? && vote.upvote?
  end

  def has_downvote_from?(user)
    vote = vote_from(user)
    vote.present? && vote.downvote?
  end

  def vote_from(user)
    votes.find_by(user: user)
  end

  def self.search(search)
    if search
      where('title ILIKE ?', "%#{search}%")
    else
      all
    end
  end
end
