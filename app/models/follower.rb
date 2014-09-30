class Follower < ActiveRecord::Base
  belongs_to :user

  validates :follower_id, presence: true
  validates :followed_id, presence: true, uniqueness: { scope: :follower_id }

  def self.create_or_delete(user1, user2)
    following = find_by(follower_id: user1.id, followed_id: user2)
    if following
      following.delete
    else
      create(follower_id: user1.id, followed_id: user2.id)
    end
  end
end
