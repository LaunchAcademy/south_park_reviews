require 'rails_helper'
feature 'User follows user' do
  let(:user1) { FactoryGirl.create(:user) }
  let(:user2) { FactoryGirl.create(:user) }
  scenario 'User1 follows user2' do
    sign_in_as(user1)
    visit user_path(user2)
    click_button "Follow #{user2.username}"
    expect(page).to have_content "#{user2.username} followed."
    expect(page).to have_button "Unfollow #{user2.username}"
    expect(page).to_not have_button "Follow #{user2.username}"
    expect(page).to have_content "#{user2.username} followed"
  end

  scenario 'User tries to follow himself' do
    sign_in_as(user1)
    visit user_path(user1)
    expect(page).to_not have_button "Follow #{user1.username}"
  end

  scenario 'User1 unfollows user2' do
    sign_in_as(user1)
    visit user_path(user2)
    click_button "Follow #{user2.username}"
    click_button "Unfollow #{user2.username}"

    expect(page).to have_content "#{user2.username} unfollowed."
    expect(page).to have_content "0 followers"
    expect(page).to have_button "Follow #{user2.username}"
    expect(page).to_not have_button "Unfollow #{user2.username}"
  end

end
