require "rails_helper"
feature 'User votes' do
  let(:episode) { FactoryGirl.create(:episode) }
  scenario 'User clicks Upvote' do
    user = FactoryGirl.create(:user)
    sign_in_as(user)
    visit episode_path(episode)


    find("#up-vote").click
    expect(page).to have_content 'User score: 1'

    find("#up-vote").click
    expect(page).to have_content 'User score: 0'

    find("#down-vote").click
    expect(page).to have_content 'User score: -1'
  end
end
