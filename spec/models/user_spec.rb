require 'rails_helper'

describe User do

  it { should respond_to(:relationships) }
  it { should respond_to(:followed_users) }
  it { should respond_to(:follow!) }
  it { should respond_to(:reverse_relationships) }
  it { should respond_to(:followers) }

  describe "#follow!" do
    let(:user) { FactoryGirl.create(:user) }
    let(:other_user) { FactoryGirl.create(:user) }

    it "follows another user" do
      user.follow!(other_user)

      # expect(user.following?(user)).to eq true
      expect(user).to be_following(other_user)
    end
    it "and #unfollow" do
      user.follow!(other_user)
      user.unfollow!(other_user)

      expect(user).to_not be_following(other_user)
    end
  end

  describe "#followed_users" do
    it "creates relationship for following" do
      relationship = FactoryGirl.create(:relationship)
      followed = relationship.followed
      follower = relationship.follower

      expect(follower.followed_users).to include followed
    end
  end

  describe "#followers" do
    it "creates relationship for followed" do
      relationship = FactoryGirl.create(:relationship)
      followed = relationship.followed
      follower = relationship.follower

      expect(followed.followers).to include follower
    end
  end

  describe "#favorite" do
    let(:user) { FactoryGirl.create(:user) }
    let(:episode) { FactoryGirl.create(:episode) }

    it "creates favorite for episode" do
      favorite = FactoryGirl.create(:favorite)
      u = favorite.user
      e = favorite.episode

      expect(u.episodes).to include e
    end

    it "creates favorite with episode" do
      user.favorite!(episode)

      expect(user).to be_favoriting(episode)
    end

    it "deletes favorite with episode" do
      user.favorite!(episode)
      user.unfavorite!(episode)

      expect(user).to_not be_favoriting(episode)
    end
  end
end
