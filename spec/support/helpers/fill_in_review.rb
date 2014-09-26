def write_review
  @user = FactoryGirl.create(:user)
  episode = Episode.find_by(title: 'An Elephant Makes Love to a Pig')
  sign_in_as(@user)
  visit episode_path(episode)

  click_on 'Add Review'
  fill_in 'review[body]', with: 'Gosh golly, this is the best darn thing I have ever seen. Best episode ever.'
  click_button 'Submit'

  expect(page).to have_content 'Your review was submitted.'
end
