class EpisodeMailer < ActionMailer::Base
  default from: "cartman@yomama.com"

  def new_episode(episode, user)
    @episode = episode
    @user = user

    mail(to: @user.email, subject: 'Here is a new episode matee')
  end
end
