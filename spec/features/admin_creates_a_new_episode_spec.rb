require "rails_helper"
feature 'User creates a new episode as Admin' do
  scenario 'Admin successfully creates a new episode' do
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
end
