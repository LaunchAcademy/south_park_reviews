class EpisodesController < ApplicationController
  def index
    @episodes = Episode.order(:season, :episode_number).page params[:page]
  end

  def new
    @episode = Episode.new
  end

  def create
    @episode = Episode.new(episode_params)
    if @episode.save
      flash[:notice] = "Episode submitted"
      redirect_to episodes_path
    else
      flash[:notice] = "Invalid entry"
      render :new
    end
  end

  def show
    @episode = Episode.find(params[:id])
  end

  def edit
    @episode = Episode.find(params[:id])
  end

  def update
    @episode = Episode.find(params[:id])
    if @episode.update(episode_params)
      flash[:notice] = "episode updated"
      redirect_to "/episodes/#{params[:id]}"
    else
      flash[:notice] = "Invalid entry"
      render :edit
    end
  end

  def destroy
    @episode = Episode.find(params[:id])
    @episode.destroy
    redirect_to "/episodes"
  end

  private

  def episode_params
    params.require(:episode).permit(:title, :synopsis, :release_date, :url, :season, :episode_number)
  end

end
