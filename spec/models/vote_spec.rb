require 'rails_helper'

describe Vote do
  describe "#upvote?" do
    it "is an upvote if value is 1" do
      vote = Vote.new(value: 1)
      # expect(vote.upvote?).to eq true
      expect(vote).to be_upvote
    end

    it "is not an upvote if value is not 1" do
      vote = Vote.new(value: 123123)
      expect(vote).to_not be_upvote
    end
  end
end
