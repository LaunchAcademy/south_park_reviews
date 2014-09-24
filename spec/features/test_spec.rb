require 'rails_helper'

feature "User signs up" do
  scenario "user signs up successfully" do
    visit new_user_registration_path
    fill_in "Email", with: 'frank@tank.com' #can also user css id's
    fill_in 'Username', with: 'tanktheFrank'
    fill_in 'user_password', with: "something"
    fill_in 'Password confirmation', with: "something"
    click_on "Sign up"

    expect(page).to have_content "Welcome! You have signed up successfully."
  end

  scenario "user signs up with invalid info" do
    visit new_user_registration_path
    fill_in 'Email', with: 'frank@tank.com'
    fill_in 'Username', with: 'frank'
    fill_in 'user_password', with: 'password'
    fill_in 'Password confirmation', with: 'passward'
    click_on 'Sign up'

    expect(page).to have_content "doesn't match Password"
  end
end

feature "User updates their account" do
  scenario "User edits their account successfully" do
    user = FactoryGirl.create(:user)
    sign_in_as(user)
    visit edit_user_registration_path
    fill_in 'Name', with: 'frank'
    fill_in 'user[current_password]', with: user.password
    click_button 'Update'

    expect(page).to have_content 'You updated your account successfully.'
  end

  scenario "User edits their account unsuccessfully" do
    user = FactoryGirl.create(:user)
    sign_in_as(user)
    visit edit_user_registration_path
    fill_in 'Username', with: ''
    click_button 'Update'
    expect(page).to have_content "Please review the problems below:"
  end
end

feature "User updates their account" do
  scenario "User deletes his account successfully" do
    user = FactoryGirl.create(:user)
    sign_in_as(user)
    visit edit_user_registration_path
    click_on 'Cancel my account'

    expect(page).to have_content 'Your account was successfully cancelled.'
  end
end
