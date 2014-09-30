require 'rails_helper'
feature 'Episode Security:' do
let(:episode) { FactoryGirl.create(:episode) }
  scenario 'Regular user tries to create an episode' do
      user = FactoryGirl.create(:user)
      sign_in_as(user)
      visit new_episode_path

      expect(page).to have_content 'You do not have rights for this command'
    end

  scenario 'Regular user tries to edit an episode do' do
    user = FactoryGirl.create(:user)
    sign_in_as(user)
    visit edit_episode_path(episode)

    expect(page).to have_content 'You do not have rights for this command'
  end
end
