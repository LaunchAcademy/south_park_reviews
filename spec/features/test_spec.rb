require 'rails_helper'

feature 'User signs up' do
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
  set_up
  episode = Episode.find_by(title: 'An Elephant Makes Love to a Pig')

  scenario 'User visits episode successfully(unsigned in)' do
    visit episode_path(episode)

    expect(page).to have_content 'An Elephant Makes Love to a Pig'
    expect(page).to have_content 'Want to write a review? Please sign in!'
  end

  scenario 'User visits episode successfully(signed in)' do
    user = FactoryGirl.create(:user)
    sign_in_as(user)
    visit episode_path(episode)

    expect(page).to have_content 'An Elephant Makes Love to a Pig'
    expect(page).to have_content 'Add Review'
  end

  scenario 'User creates a new episode as Admin' do
    admin = FactoryGirl.create(:user)
    authenticate_admin(admin)
    visit new_episode_path
    fill_in 'episode_title', with: 'Cartman goes to the zoo'
    select '24', from: 'episode_season'
    select '24', from: 'episode_episode_number'
    click_button 'Create Episode'

    expect(page).to have_content 'Episode submitted'
  end

  scenario 'Non admin tries to create an episode' do
    user = FactoryGirl.create(:user)
    sign_in_as(user)
    visit new_episode_path

    expect(page).to have_content 'You do not have rights for this command'
  end

  scenario 'Admin tries to edit an episode' do
    admin = FactoryGirl.create(:user)
    episode = Episode.find_by(title: 'An Elephant Makes Love to a Pig')
    authenticate_admin(admin)
    visit edit_episode_path(episode)
    fill_in 'episode_title', with: 'Cartman Sucks Weiner'
    save_and_open_page
    click_on 'Update Episode'

    expect(page).to have_content 'Cartman is a character'
  end
end
