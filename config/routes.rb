Rails.application.routes.draw do
  devise_for :users
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"

  root 'episodes#index'

  resources :users, only: [:show] do
    member do
      get :following, :followers
    end
  end

  resources :favorites, only: [:create, :destroy]
  resources :relationships, only: [:create, :destroy]

  put "episodes/:id/vote/:vote_value", to: "episodes#vote", as: :episode_vote


  concern :paginatable do
    get '(page/:page)', :action => :index, :on => :collection, :as => ''
  end

  scope concerns: :paginatable do
    resources :episodes do
      resources :reviews, only: [:new, :create, :edit, :update, :destroy]
    end
  end

  namespace :admin do
    resources :users, only: [:update, :destroy]
  end
end
