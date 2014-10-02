require "rails_helper"
feature 'User writes a review' do
  let(:episode) { FactoryGirl.create(:episode) }
  let(:user) { FactoryGirl.create(:user) }
  scenario 'User writes a review successfully' do
    sign_in_as(user)
    visit episode_path(episode)

    click_on 'Add Review'
    fill_in 'review[body]', with: 'This string is too short'
    click_button 'Submit'

    fill_in 'review[body]', with: 'Gosh golly, this is the best darn thing I have ever seen. Best episode ever.'
    click_button 'Submit'

    expect(page).to have_content 'Your review was submitted.'
  end

  scenario 'User edits his review' do
    sign_in_as(user)
    visit episode_path(episode)
    click_on 'Add Review'
    fill_in 'review[body]', with: 'Gosh golly, this is the best darn thing I have ever seen. Best episode ever.'
    click_button 'Submit'

    click_on 'Edit'
    fill_in 'review[body]', with: 'This string is too short.'
    click_button 'Submit'
    expect(page).to have_content 'is too short'

    fill_in 'review[body]', with: 'Gee whillickers, I actually decided that this episode stinks. South Park really should improve.'
    click_button 'Submit'
    expect(page).to have_content 'Your review was updated.'
  end

  scenario 'User destroys his review' do
    sign_in_as(user)
    visit episode_path(episode)
    click_on 'Add Review'
    fill_in 'review[body]', with: 'Gosh golly, this is the best darn thing I have ever seen. Best episode ever.'
    click_button 'Submit'

    click_on 'Delete'
    expect(page).to have_content 'Review was deleted.'
  end

  scenario "User tries to edit someone else's review" do
    sign_in_as(user)
    visit episode_path(episode)

    click_on 'Add Review'
    fill_in 'review[body]', with: 'Gosh golly, this is the best darn thing I have ever seen. Best episode ever.'
    click_button 'Submit'

    expect(page).to have_content 'Your review was submitted.'
    review = episode.reviews.first
    click_on 'Sign out'
    user2 = FactoryGirl.create(:user)
    sign_in_as(user2)
    visit episode_path(episode)
    visit "/episodes/#{episode.id}/reviews/#{review.id}/edit"

    expect(page).to have_content "You aren't signed in as the original author."
  end
  scenario 'User creates a review with markdown' do
    sign_in_as(user)
    visit episode_path(episode)

    click_on 'Add Review'
    fill_in 'review[body]', with: '**bold** *italics* Gosh golly, this is the best darn thing I have ever seen. Best episode ever.'
    click_button 'Submit'

    expect(page).to_not have_content '**bold** *italics*'
  end

end
