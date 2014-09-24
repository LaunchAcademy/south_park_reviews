class EpisodeVotes < ActiveRecord::Base
  belongs_to :user
  belongs_to :episode

  validates :user_id, presence: true
  validates :episode_id, presence: true
  validates :upvote?, presence: true
end
