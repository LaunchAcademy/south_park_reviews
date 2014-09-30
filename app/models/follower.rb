class Follower < ActiveRecord::Base
  belongs_to :user

  validates :follower, presence: true
  validates :user_id, presence: true, uniqueness: { scope: :follower }

  def self.create_or_delete(user1, user2)
    following = find_by(follower: user1.id, user_id: user2)
    if following
      following.delete
    else
      create(follower: user1.id, user_id: user2.id)
    end
  end
end
