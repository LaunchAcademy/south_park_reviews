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
    # before do
    #   @user.save
    #   @user.follow!(other_user)
    # end

    # it { should be_following(other_user) }
    # its(:followed_users) { should include(other_user) }}

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

      # expect(user.following?(user)).to eq true
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

end
