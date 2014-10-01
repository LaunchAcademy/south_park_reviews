require 'rails_helper'
feature 'follower behavior' do
  let(:user1) { FactoryGirl.create(:user) }
  let(:user2) { FactoryGirl.create(:user) }

  scenario 'User1 has not created follow for user2' do

    expect(user1.follows?(user2)).to eq(false)
  end

  scenario 'User1 creates follow for user2' do
    Follower.create_or_delete(user1, user2)

    expect(user1.follows?(user2)).to eq(true)
  end

  scenario 'User1 creates and deletes follow for user2' do
    Follower.create_or_delete(user1, user2)
    Follower.create_or_delete(user1, user2)

    expect(user1.follows?(user2)).to eq(false)
  end

  scenario 'User1 follows user1' do
    sign_in_as(user1)
    visit user_path(user1)
    click_button "Follow #{user1.username}"

    expect(page).to have_content 'You cannot follow yourself!'
  end

  scenario 'User1 follows user2' do
    sign_in_as(user1)
    visit user_path(user2)
    click_button "Follow #{user2.username}"

    expect(page).to have_content "#{user2.username} followed"
    #I would also like to test to see if the url for user2 exists on page
    #This does not work:
    # expect(page).to have_link "/users/#{user2.id}"
  end

  scenario 'User1 un-follows user2' do
    sign_in_as(user1)
    visit user_path(user2)
    click_button "Follow #{user2.username}"
    first(:button, "Unfollow #{user2.username}").click
    expect(page).to_not have_content "#{user2.username} followed"
    expect(page).to have_content "#{user2.username} un-followed"
  end

end
