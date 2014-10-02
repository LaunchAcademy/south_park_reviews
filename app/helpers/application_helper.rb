module ApplicationHelper
  def user_avatar(user, options={})
    url = if user.profile_image.url
      user.profile_image.url
    elsif user.avatar_url
      user.avatar_url
    else
      'MrG.png'
    end
    default_options = { height: 40, width: 40 }

    image_tag(url, default_options.merge(options))
  end

  def render_markdown(markdown)
    extensions = { hard_wrap: true }
    renderer = Redcarpet::Markdown.new(Redcarpet::Render::HTML, extensions)
    renderer.render(markdown || "").html_safe
  end
end
