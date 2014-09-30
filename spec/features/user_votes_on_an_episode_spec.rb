require "rails_helper"
feature 'User votes on an episode' do
let(:episode) { FactoryGirl.create(:episode) }
let(:user) { FactoryGirl.create(:user) }
  scenario "user upvotes an episode" do
    sign_in_as(user)
    visit episode_path(episode)
    find("#up-vote").click

    expect(page).to have_content 'User score: 1'
  end

  scenario "user downvotes an episode" do
    sign_in_as(user)
    visit episode_path(episode)
    find("#down-vote").click

    expect(page).to have_content 'User score: -1'
  end

  scenario "voting the same way twice undoes their previous vote" do
    sign_in_as(user)
    visit episode_path(episode)
    find("#up-vote").click

    expect(page).to have_content 'User score: 1'

    find("#up-vote").click

    expect(page).to have_content 'User score: 0'
  end
end
