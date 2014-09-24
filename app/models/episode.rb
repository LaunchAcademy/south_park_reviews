class Episode < ActiveRecord::Base
  has_many :reviews
  has_many :upvotes

end
