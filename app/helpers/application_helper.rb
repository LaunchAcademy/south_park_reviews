module ApplicationHelper
  def user_avatar(user, options={})
    url = if user.profile_image.url
      user.profile_image.url
    elsif user.avatar_url
      user.avatar_url
    else
      'MrG.png'
    end
    default_options = { height: 48, width: 48 }
    image_tag(url, default_options.merge(options))
  end
end
