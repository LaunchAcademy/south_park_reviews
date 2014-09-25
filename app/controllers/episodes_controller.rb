class EpisodesController < ApplicationController
  def index
    @episodes = Episode.order(:season, :episode_number).page(params[:page])
  end

  def show
    @episode = Episode.find(params[:id])
    @reviews = @episode.reviews.order(created_at: :desc)
  end

  def new
    authorize_admin(current_user)
    @episode = Episode.new
  end

  def create
    authorize_admin(current_user)
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
    authorize_admin(current_user)
    @episode = Episode.find(params[:id])
  end

  def update
    authorize_admin(current_user)
    @episode = Episode.find(params[:id])
    if @episode.update(episode_params)
      flash[:notice] = "episode updated"
      redirect_to episode_path(@episode)
    end
  end

  def destroy
    authorize_admin(current_user)
    @episode = Episode.find(params[:id])
    @episode.destroy
    redirect_to "/episodes"
  end

  private

  def episode_params
    params.require(:episode).permit(:title, :synopsis, :release_date, :url, :season, :episode_number)
  end
end
