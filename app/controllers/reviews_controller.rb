class ReviewsController < ApplicationController
  before_action :authenticate_user!
  def new
    @episode = Episode.find(params[:episode_id])
    @review = Review.new
  end

  def create

    renderer = Redcarpet::Render::HTML.new(hard_wrap: true)
    markdown = Redcarpet::Markdown.new(renderer, extensions = {})
    @episode = Episode.find(params[:episode_id])
    markdown_params = review_params
    markdown_params[:body] = markdown.render(review_params[:body])
    @review = @episode.reviews.build(markdown_params)
    @review.user = current_user
    if @review.save
      redirect_to @episode, notice: "Your review was submitted."
    else
      render 'new'
    end
  end

  def edit
    find_authorized_review
  end

  def update
    find_authorized_review
    renderer = Redcarpet::Render::HTML.new(hard_wrap: true)
    markdown = Redcarpet::Markdown.new(renderer, extensions = {})
    markdown_params = review_params
    markdown_params[:body] = markdown.render(review_params[:body])
    if @review.update(markdown_params)
      @review.update(body: markdown.render(review_params[:body]))
      redirect_to @episode, notice: 'Your review was updated.'
    else
      render 'edit'
    end
  end


  def destroy
    find_authorized_review
    @review.destroy
    redirect_to @episode, notice: 'Your review was deleted.'
  end

  private
  def review_params
    params.require(:review).permit(:body)
  end

  def find_authorized_review
    @episode = Episode.find(params[:episode_id])
    @review = @episode.reviews.find(params[:id])
    authorize_user_for_action!(@review.user)
  end
end
