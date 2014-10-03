require 'rails_helper'
feature 'User favorites episode' do
  let(:user) { FactoryGirl.create(:user) }
  let(:episode) { FactoryGirl.create(:episode) }
  scenario 'User favorites episode' do
    sign_in_as(user)
    visit episode_path(episode)
    click_button "Add to favorites"

    expect(page).to have_content "Added to favorites"
    expect(page).to_not have_button "Add to favorites"
    expect(page).to have_button "Remove from favorites"
    #check user page for episode

  end

  scenario 'User unfavorites episode' do
    sign_in_as(user)
    visit episode_path(episode)
    click_button "Add to favorites"
    click_button "Remove from favorites"

    expect(page).to have_content "Removed from favorites"
    expect(page).to have_button "Add to favorites"
    expect(page).to_not have_button "Remove from favorites"
  end

end
