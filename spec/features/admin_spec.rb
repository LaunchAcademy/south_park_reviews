require "rails_helper"
feature 'Episode Priviledges' do
  let(:episode) { FactoryGirl.create(:episode) }
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

  scenario 'Admin tries to edit an episode successfully' do
    admin = FactoryGirl.create(:admin)
    sign_in_as(admin)
    visit edit_episode_path(episode)
    fill_in 'episode_title', with: 'Cartman is a character'
    click_on 'Update Episode'

    expect(page).to have_content 'Cartman is a character'
  end

  scenario 'Admin deletes an episode' do
    admin = FactoryGirl.create(:admin)
    sign_in_as(admin)
    visit episode_path(episode)
    click_on 'Delete'

    expect(page).to have_content 'episode deleted'
  end

  scenario 'User tries to create an episode' do
    user = FactoryGirl.create(:user)
    sign_in_as(user)
    visit new_episode_path

    expect(page).to have_content 'You do not have rights for this command.'
  end
end
