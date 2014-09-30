require "rails_helper"
feature 'User deletes his account' do
  scenario 'User deletes his account successfully' do
    user = FactoryGirl.create(:user)
    sign_in_as(user)
    visit edit_user_registration_path
    click_on 'Cancel my account'

    expect(page).to have_content 'Your account was successfully cancelled.'
  end
end
