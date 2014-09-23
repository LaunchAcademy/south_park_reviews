module ApplicationHelper
  def user_avatar(user, options={})
    url = user.avatar_url || 'MrG.png'
    default_options = { height: 48, width: 48 }

    image_tag(url, default_options.merge(options))
  end
end
