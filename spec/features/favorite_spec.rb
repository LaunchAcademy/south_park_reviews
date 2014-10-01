require 'rails_helper'
feature 'follower behavior' do
  let(:user) { FactoryGirl.create(:user) }
  let(:episode) { FactoryGirl.create(:episode) }

  scenario 'User has not created favorite for episode' do

    expect(user.favorites?(episode)).to eq(false)
  end

  scenario 'User creates favorite for episode' do
    Favorite.create_or_delete(user, episode)

    expect(user.favorites?(episode)).to eq(true)
  end

  scenario 'User creates and deletes favorite for episode' do
    Favorite.create_or_delete(user, episode)
    Favorite.create_or_delete(user, episode)

    expect(user.favorites?(episode)).to eq(false)
  end

  scenario 'User favorites episode' do
    sign_in_as(user)
    visit episode_path(episode)
    click_button "Add to favorites"

    expect(page).to have_content 'Added to favorites.'
  end

  scenario 'User un-favorites episode' do
    sign_in_as(user)
    visit episode_path(episode)
    click_button "Add to favorites"
    click_button "Remove from favorites"

    expect(page).to have_content 'Removed from favorites.'
  end

  scenario 'User favorites episode' do
    sign_in_as(user)
    visit episode_path(episode)
    click_button "Add to favorites"
    click_on "#{user.username}"

    expect(page).to have_content episode.title
  end
end

