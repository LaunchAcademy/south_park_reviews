class EpisodesController < ApplicationController
  def index
    @episodes = Episode.order(:season, :episode_number)
  end

  def show
    @episode = Episode.find(params[:id])
  end

end
