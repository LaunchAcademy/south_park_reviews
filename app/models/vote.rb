class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :voteable, polymorphic: true

validates :user, presence: true
validates :voteable, uniqueness: { scope: :user }
validates :voteable_id, presence: true
validates :value, inclusion: { in: [1, -1] }
validates :voteable_type, inclusion: { in: %w(episode review) }

  def switch_vote
    self.value = -self.value
    self.save
  end
end
