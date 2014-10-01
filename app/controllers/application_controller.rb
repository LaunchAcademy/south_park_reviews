class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?
  helper_method :voted_on_episode?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :email, :password, :password_confirmation, :remember_me) }
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:login, :password, :remember_me) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:username, :email, :profile_image, :password, :password_confirmation, :current_password, :avatar_url, :name) }
  end

  def authorize_user_for_action!(author)
    unless current_user == author || current_user.admin?
      redirect_to root_path, notice: "You aren't signed in as the original author."
    end
  end

  def authorize_admin!
    unless current_user && current_user.admin?
      redirect_to root_path, notice: "You do not have rights for this command."
    end
  end

  helper
  def voted_on_episode?(user, episode)
    if @episode
      episode = @episode
    end
    vote = Vote.find_by(voteable_id: episode.id, user_id: user.id)
  end

  def display_index_with(query)
    if query[:season]
      @episodes = Episode.where(season: query[:season]).order(:episode_number).page(query[:page])
    elsif query[:search]
      @episodes = Episode.search(query[:search]).order(:season, :episode_number).page(query[:page])
    else
      @episodes = Episode.order(:season, :episode_number).page(query[:page])
    end
  end
end
