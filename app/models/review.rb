class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :episode

  validates :body, presence: { message: "can't be blank." },
  length: { minimum: 50, too_short: "must have at least %{count} characters."}
  validates :user, :episode, presence: true
end
