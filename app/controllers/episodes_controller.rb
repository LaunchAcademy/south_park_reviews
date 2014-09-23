class EpisodesController < ApplicationController
  def index
    @episodes = Episode.order(:season, :episode_number)
  end

end
