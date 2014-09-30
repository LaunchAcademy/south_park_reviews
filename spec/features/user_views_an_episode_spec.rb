require "rails_helper"
feature 'User interacts with episode' do
  let(:episode) { FactoryGirl.create(:episode) }
  scenario 'User visits episode successfully(unsigned in)' do
    visit episode_path(episode)

    expect(page).to have_content 'An Elephant Makes Love to a Pig'
    expect(page).to have_content 'Want to write a review?'
  end

  scenario 'User visits episode successfully(signed in)' do
    user = FactoryGirl.create(:user)
    sign_in_as(user)
    visit episode_path(episode)

    expect(page).to have_content episode.title
    expect(page).to have_content 'Add Review'
  end
end
