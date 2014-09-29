class EpisodesController < ApplicationController
  before_action :authenticate_user!,
  only: [:create, :update, :edit, :update, :destroy, :vote]
  def index
    @episodes = Episode.search(params[:search]).order(:season, :episode_number).page(params[:page])
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

    Episode.destroy(params[:id])

    redirect_to episodes_path, notice: 'episode deleted'
  end

  def vote
    episode = Episode.find(params[:id])
    vote = episode.votes.find_or_initialize_by(user: current_user)

    if params[:vote_value].to_i == vote.value
      vote.delete
    else
      vote.value = params[:vote_value]
      vote.save
    end

    redirect_to episode_path(params[:id])
  end

  private

  def episode_params
    # binding.pry
    # params.require(:episode).permit(:title, :synopsis, :release_date, :url, :season, :episode_number, :search)
  end
end
