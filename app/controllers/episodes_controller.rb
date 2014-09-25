class EpisodesController < ApplicationController
  def index
    @episodes = Episode.order(:season, :episode_number).page(params[:page])
  end

  def show
    @episode = Episode.find(params[:id])
    @reviews = @episode.reviews.order(created_at: :desc)
  end

  def new
    authorize_admin!(current_user)
    @episode = Episode.new
  end

  def create
    authorize_admin!(current_user)
    @episode = Episode.new(episode_params)
    if @episode.save
      flash[:notice] = "Episode submitted"
      redirect_to episodes_path
    else
      flash[:notice] = "Invalid entry"
      render :new
    end
  end

  def edit
    authorize_admin!(current_user)
    @episode = Episode.find(params[:id])
  end

  def update
    authorize_admin!(current_user)
    @episode = Episode.find(params[:id])
    if @episode.update(episode_params)
      flash[:notice] = "Episode updated."
      redirect_to episode_path(@episode)
    end
  end

  def destroy
    authorize_admin!(current_user)
    @episode = Episode.find(params[:id])
    @episode.destroy
    redirect_to "/episodes"
  end

  def vote
    vote = Vote.find_by(voteable_id: params[:id],
      user_id: current_user.id,
      voteable_type: 'episode')
    if vote.nil?
      v = Vote.new(voteable_id: params[:id],
        user_id: current_user.id,
        voteable_type: 'episode',
        value: params[:vote_value])
      v.save
    elsif params[:vote_value].to_i == vote.value
      vote.delete
    else

      vote.switch_vote
    end
    redirect_to episode_path(params[:id])
  end

  private

  def episode_params
    params.require(:episode).permit(:title, :synopsis, :release_date, :url, :season, :episode_number)
  end
end
