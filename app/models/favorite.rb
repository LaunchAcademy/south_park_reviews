class Favorite < ActiveRecord::Base
  belongs_to :user
  belongs_to :episode

  validates :user_id, presence: true
  validates :episode_id, presence: true

  def self.create_or_delete(user, episode)
    favorite = find_by(user_id: user.id, episode_id: episode.id)
    if favorite
      favorite.delete
    else
      create(user_id: user.id, episode_id: episode.id)
    end
  end

end
