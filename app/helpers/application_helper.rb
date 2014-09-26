module ApplicationHelper
  def user_avatar(user, options={})
    # binding.pry
    if user.profile_image.url
      url = user.profile_image.url
    elsif user.avatar_url
      url = user.avatar_url
    else
      url = 'MrG.png'

    end
    # url = user.avatar_url? ? user.avatar_url : url = 'MrG.png'
    default_options = { height: 48, width: 48 }
    image_tag(url, default_options.merge(options))
  end
end
