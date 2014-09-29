require 'rails_helper'
feature 'We make a new user' do
  scenario "user signs up successfully" do
    visit new_user_registration_path
    fill_in 'Email', with: 'frank@tank.com' #can also user css id's
    fill_in 'Username', with: 'tanktheFrank'
    fill_in 'user_password', with: 'something'
    fill_in 'Password confirmation', with: 'something'
    click_on 'Sign up'

    expect(page).to have_content 'Welcome! You have signed up successfully.'
  end

  scenario 'user signs up with invalid info' do
    visit new_user_registration_path
    fill_in 'Email', with: 'frank@tank.com'
    fill_in 'Username', with: 'frank'
    fill_in 'user_password', with: 'password'
    fill_in 'Password confirmation', with: 'passward'
    click_on 'Sign up'

    expect(page).to have_content "doesn't match Password"
  end
end

feature 'User updates their account' do
  scenario 'User edits their account successfully' do
    user = FactoryGirl.create(:user)
    sign_in_as(user)
    visit edit_user_registration_path
    fill_in 'Name', with: 'frank'
    fill_in 'user[current_password]', with: user.password
    click_button 'Update'

    expect(page).to have_content 'You updated your account successfully.'
  end

  scenario 'User edits their account unsuccessfully' do
    user = FactoryGirl.create(:user)
    sign_in_as(user)
    visit edit_user_registration_path
    fill_in 'Username', with: ''
    click_button 'Update'
    expect(page).to have_content 'Please review the problems below:'
  end
end

feature 'User updates their account' do
  scenario 'User deletes his account successfully' do
    user = FactoryGirl.create(:user)
    sign_in_as(user)
    visit edit_user_registration_path
    click_on 'Cancel my account'

    expect(page).to have_content 'Your account was successfully cancelled.'
  end
end

feature 'User interacts with episode' do
  let(:episode) { FactoryGirl.create(:episode) }
  scenario 'User visits episode successfully(unsigned in)' do
    visit episode_path(episode)

    expect(page).to have_content 'An Elephant Makes Love to a Pig'
    expect(page).to have_content 'Want to write a review?'
  end

  scenario 'User visits episode successfully(signed in)' do
    user = FactoryGirl.create(:user)
    sign_in_as(user)
    visit episode_path(episode)

    expect(page).to have_content episode.title
    expect(page).to have_content 'Add Review'
  end

  scenario 'User creates a new episode as Admin' do
    admin = FactoryGirl.create(:admin)
    sign_in_as(admin)
    visit new_episode_path
    fill_in 'episode_title', with: 'Cartman goes to the zoo'
    select '24', from: 'episode_season'
    select '24', from: 'episode_episode_number'
    click_button 'Create Episode'

    expect(page).to have_content 'Episode submitted'
  end

  scenario 'Admin unsuccessfully creates an episode' do
    admin = FactoryGirl.create(:admin)
    sign_in_as(admin)
    visit new_episode_path
    fill_in 'episode_title', with: ''
    select '24', from: 'episode_season'
    select '24', from: 'episode_episode_number'
    click_button 'Create Episode'

    expect(page).to have_content 'Invalid entry'
  end

  scenario 'Non admin tries to create an episode' do
    user = FactoryGirl.create(:user)
    sign_in_as(user)
    visit new_episode_path

    expect(page).to have_content 'You do not have rights for this command'
  end

  scenario 'Admin tries to edit an episode' do
    admin = FactoryGirl.create(:admin)
    sign_in_as(admin)

    visit edit_episode_path(episode)
    fill_in 'episode_title', with: 'Cartman is a character'
    click_on 'Update Episode'

    expect(page).to have_content 'Cartman is a character'
  end

  scenario 'Regular user tries to edit an episode do' do
    user = FactoryGirl.create(:user)
    sign_in_as(user)
    visit edit_episode_path(episode)

    expect(page).to have_content 'You do not have rights for this command'
  end

  scenario 'Admin deletes an episode' do
    admin = FactoryGirl.create(:admin)
    sign_in_as(admin)
    visit episode_path(episode)
    click_on 'Delete'

    expect(page).to have_content 'episode deleted'
  end
end

feature 'User votes' do
  let(:episode) { FactoryGirl.create(:episode) }
  scenario 'User clicks Upvote' do
    user = FactoryGirl.create(:user)
    sign_in_as(user)
    visit episode_path(episode)


    find("#up-vote").click
    expect(page).to have_content 'User score: 1'

    find("#up-vote").click
    expect(page).to have_content 'User score: 0'

    find("#down-vote").click
    expect(page).to have_content 'User score: -1'
  end
end

feature 'User writes a review' do
  let(:episode) { FactoryGirl.create(:episode) }
  scenario 'User writes a review successfully' do
    user = FactoryGirl.create(:user)
    sign_in_as(user)
    visit episode_path(episode)

    click_on 'Add Review'
    fill_in 'review[body]', with: 'This string is too short'
    click_button 'Submit'

    fill_in 'review[body]', with: 'Gosh golly, this is the best darn thing I have ever seen. Best episode ever.'
    click_button 'Submit'

    expect(page).to have_content 'Your review was submitted.'
  end

  scenario 'User edits his review' do
    user = FactoryGirl.create(:user)
    sign_in_as(user)
    visit episode_path(episode)
    click_on 'Add Review'
    fill_in 'review[body]', with: 'Gosh golly, this is the best darn thing I have ever seen. Best episode ever.'
    click_button 'Submit'

    click_on 'Edit'
    fill_in 'review[body]', with: 'This string is too short.'
    click_button 'Submit'
    expect(page).to have_content 'is too short'

    fill_in 'review[body]', with: 'Gee whillickers, I actually decided that this episode stinks. South Park really should improve.'
    click_button 'Submit'
    expect(page).to have_content 'Your review was updated.'
  end

  scenario 'User destroys his review' do
    user = FactoryGirl.create(:user)
    sign_in_as(user)
    visit episode_path(episode)
    click_on 'Add Review'
    fill_in 'review[body]', with: 'Gosh golly, this is the best darn thing I have ever seen. Best episode ever.'
    click_button 'Submit'

    click_on 'Delete'
    expect(page).to have_content 'Your review was deleted.'
  end

  scenario "User tries to edit someone else's review" do
    user = FactoryGirl.create(:user)
    sign_in_as(user)
    visit episode_path(episode)

    click_on 'Add Review'
    fill_in 'review[body]', with: 'Gosh golly, this is the best darn thing I have ever seen. Best episode ever.'
    click_button 'Submit'

    expect(page).to have_content 'Your review was submitted.'
    review = episode.reviews.first
    click_on 'Sign out'
    user2 = FactoryGirl.create(:user)
    sign_in_as(user2)
    visit episode_path(episode)
    visit "/episodes/#{episode.id}/reviews/#{review.id}/edit"

    expect(page).to have_content "You aren't signed in as the original author."
  end
end
