class ReviewsController < ApplicationController
  def new
    @episode = Episode.find(params[:episode_id])
    @review = Review.new
  end

  def create
    @episode = Episode.find(params[:episode_id])
    @review = @episode.reviews.build(review_params)

    if @review.save
      redirect_to @episode, notice: "Your review was submitted."
    else
      render 'new'
    end
  end

  def update
    @episode = Episode.find(params[:episode_id])
    @review = @episode.reviews.find(params[:id])

    if @review.update(review_params)
      redirect_to @episode, notice: 'Your review was updated.'
    else
      render 'edit'
    end
  end

  def edit
    @episode = Episode.find(params[:episode_id])
    @review = @episode.reviews.find(params[:id])
  end

  def destroy
    @episode = Episode.find(params[:episode_id])
    Review.find(params[:id]).destroy
    redirect_to @episode
  end

  private
  def review_params
    params.require(:review).permit(:body, :user_id)
  end
end
