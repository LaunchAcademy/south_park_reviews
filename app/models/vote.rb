class Vote < ActiveRecord::Base
  belongs_to :user
  # belongs_to :episode
  # belongs_to :review

validates :user_id, presence: true
validates :content_id, presence: true
validates :value, inclusion: { in: [1, -1] }
validates :content_type, inclusion: { in: %w(episode review) }

  def switch_vote
    self.value = -self.value
    self.save
  end
end
