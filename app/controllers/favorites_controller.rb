class FavoritesController < ApplicationController
  def create
    @episode = Episode.find(params[:favorite][:episode_id])
    current_user.favorite!(@episode)
    flash[:notice] = "Added to favorites"
    redirect_to @episode
  end

  def destroy
    @episode = Favorite.find(params[:id]).episode
    current_user.unfavorite!(@episode)
    flash[:notice] = "Removed from favorites"
    redirect_to @episode
  end

end
