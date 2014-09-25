class Episode < ActiveRecord::Base
  has_many :reviews
  has_many :upvotes

  def vote_score
    votes = Vote.where(content_id: id)
    if votes
      votes.sum("value")
    else
      0
    end
  end
end
