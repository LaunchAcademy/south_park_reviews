require 'rails_helper'
feature 'follower behavior' do
  scenario 'User1 does not follow user2' do
    user1 = FactoryGirl.create(:user)
    user2 = FactoryGirl.create(:user)

    expect(user1.follows?(user2)).to eq(false)
  end

  scenario 'User1 creates follow for user2' do
    user1 = FactoryGirl.create(:user)
    user2 = FactoryGirl.create(:user)
    Follower.create_or_delete(user1, user2)

    expect(user1.follows?(user2)).to eq(true)
  end

  scenario 'User1 creates and deletes follow for user2' do
    user1 = FactoryGirl.create(:user)
    user2 = FactoryGirl.create(:user)
    Follower.create_or_delete(user1, user2)
    Follower.create_or_delete(user1, user2)

    expect(user1.follows?(user2)).to eq(false)
  end

end
