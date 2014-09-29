require 'rails_helper'

describe Episode do
  describe "#vote_from" do
    context "when vote exists" do
      it "returns vote for episode from given user" do
        episode = FactoryGirl.create(:episode)
        user = FactoryGirl.create(:user)
        vote = FactoryGirl.create(:vote, voteable: episode, user: user)

        expect(episode.vote_from(user)).to eq vote
      end
    end

    context "when vote exists" do
      it "returns nil" do
        episode = FactoryGirl.create(:episode)
        user = FactoryGirl.create(:user)

        expect(episode.vote_from(user)).to eq nil
      end
    end
  end

  describe "#has_upvote_from?" do
    context "when it does have an upvote from user" do
      it "returns true" do
        episode = FactoryGirl.create(:episode)
        user = FactoryGirl.create(:user)
        upvote = FactoryGirl.create(:vote, value: 1, voteable: episode, user: user)

        expect(episode).to have_upvote_from user
      end
    end

    context "when it does not have an upvote from user" do
      it "returns false" do
        episode = FactoryGirl.create(:episode)
        user = FactoryGirl.create(:user)
        upvote = FactoryGirl.create(:vote, value: -1, voteable: episode, user: user)

        expect(episode).to_not have_upvote_from user
      end
    end
  end
end
