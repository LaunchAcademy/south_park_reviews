class Episode < ActiveRecord::Base
  has_many :reviews
  has_many :votes, as: :voteable

  def vote_score
    votes = Vote.where(voteable_id: id)
    if votes
      votes.sum("value")
    else
      0
    end
  end
end
