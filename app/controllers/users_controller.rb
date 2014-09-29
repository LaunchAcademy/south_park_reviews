class UsersController < ApplicationController
  def show
    @user = User.includes(reviews: :episode).find(params[:id])
    # binding.pry
  end
end
