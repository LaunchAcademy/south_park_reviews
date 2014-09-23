class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update, :destroy]
  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to @user, notice: 'Your profile was updated'
    else
      render 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id])
    authorize_user_for_action!
    @user.destroy
    redirect_to root_path, notice: 'User deleted.'
  end

  private
  def user_params
    params.require(:user).permit(:username, :email, :name, :avatar_url)
  end

  def authorize_user_for_action!
    unless current_user.id == @user.id
      redirect_to user_path, notice: "Don't Hack This"
    end
  end
end
