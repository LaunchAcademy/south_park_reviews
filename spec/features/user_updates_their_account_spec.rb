require "rails_helper"
feature 'User updates their account' do
let(:user) { FactoryGirl.create(:user) }
  scenario 'User edits their account successfully' do
    sign_in_as(user)
    visit edit_user_registration_path
    fill_in 'Name', with: 'frank'
    fill_in 'Avatar url', with: 'http://emilines.com/wp-content/uploads/2014/09/wallpaper-games-hd-228x131.jpg'
    fill_in 'user[current_password]', with: user.password
    click_button 'Update'

    expect(page).to have_content 'You updated your account successfully.'
  end

  scenario 'User uses image uploader' do
    sign_in_as(user)
    visit edit_user_registration_path
    attach_file('user_profile_image', File.join(Rails.root, "/spec/support/fixtures/triangular-face.jpg"))
    fill_in 'user[current_password]', with: user.password
    click_button 'Update'

    expect(page).to have_content 'You updated your account successfully.'
  end

  scenario 'User edits their account unsuccessfully' do
    sign_in_as(user)
    visit edit_user_registration_path
    fill_in 'Username', with: ''
    click_button 'Update'
    expect(page).to have_content 'Please review the problems below:'
  end
end
