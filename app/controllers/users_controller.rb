class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def follow
    @user = User.find(params[:followed_user])
    if current_user.id == @user.id
      flash[:notice] = "You cannot follow yourself!"
      redirect_to user_path
    else

      if current_user.follows?(@user)
        flash[:notice] = "#{@user.username} un-followed"
      else
        flash[:notice] = "#{@user.username} followed"
      end
      if Follower.create_or_delete(current_user, @user)
        redirect_to user_path
      else
        flash[:notice] = "Cannot follow this user"
        render :new
      end
    end
  end
end
