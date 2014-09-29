module ApplicationHelper
  def user_avatar(user, options={})
    url = user.avatar_url? ? user.avatar_url : url = 'MrG.png'
    default_options = { height: 40, width: 40 }
    image_tag(url, default_options.merge(options))
  end
end
