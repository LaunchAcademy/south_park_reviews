require 'rails_helper'
feature 'User searches for an episode' do
  load "#{Rails.root}/db/seeds.rb"
  scenario 'User searches for poo' do
    visit root_path
    fill_in 'search', with: 'poo'
    click_button 'Search'

    expect(page).to have_content 'the Christmas Poo'
    expect(page).to_not have_content 'Unaired pilot (28 min)'
  end

  scenario 'User clicks on Search(Retrieving all episodes)' do
    visit root_path
    click_button 'Search'

    expect(page).to have_content 'S1E1'
  end
end
