class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def follow
    @user = params[:followed_user]
    if current_user.id = @user.id
      flash[:notice] = "You cannot follow yourself!"
      render :new
    elsif current_user.follows?(@user)
      flash[:notice] = "#{@user.username} un-followed"
      render :new

    if Follower.create(follower_id: current_user.id, @user.id)
      flash[:notice] = "#{@user.username} followed"
      redirect_to user_path
    else
      flash[:notice] = "Cannot follow this user"
      render :new
    end
  end
end
