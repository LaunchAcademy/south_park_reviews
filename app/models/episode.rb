class Episode < ActiveRecord::Base
  has_many :reviews, dependent: :destroy
  has_many :upvotes, dependent: :destroy
end
