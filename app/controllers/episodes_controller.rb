class EpisodesController < ApplicationController
  before_action :authenticate_user!,
  only: [:create, :update, :edit, :update, :destroy, :vote]
  def index
    @episodes = Episode.populate_index_with(params)
  end

  def show
    @episode = Episode.find(params[:id])
    @reviews = @episode.reviews.order(created_at: :desc)
    if current_user
      @vote = voted_on_episode?(current_user, @episode)
    end
  end

  def new
    authorize_admin!
    @episode = Episode.new
  end

  def create
    authorize_admin!
    @episode = Episode.new(episode_params)
    if @episode.save
      User.find_each do |user|
        EpisodeMailer.new_episode(@episode, user).deliver
      end

      flash[:notice] = "Episode submitted"
      redirect_to episodes_path
    else
      flash[:notice] = "Invalid entry"
      render :new
    end
  end

  def edit
    authorize_admin!
    @episode = Episode.find(params[:id])
  end

  def update
    authorize_admin!

    renderer = Redcarpet::Render::HTML.new(hard_wrap: true)
    markdown = Redcarpet::Markdown.new(renderer, extensions = {})
    @episode = Episode.find(params[:id])
    markdown_params = episode_params
    markdown_params[:synopsis] = markdown.render(episode_params[:synopsis])
    if @episode.update(markdown_params)
      flash[:notice] = "Episode updated."
      redirect_to episode_path(@episode)
    end
  end

  def destroy
    authorize_admin!

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
    params.require(:episode).permit(:title, :synopsis, :release_date, :url, :season, :episode_number, :search)
  end
end
