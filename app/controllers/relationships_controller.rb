class RelationshipsController < ApplicationController
  def create
    @user = User.find(params[:relationship][:followed_id])
    current_user.follow!(@user)
    flash[:notice] = "#{@user.username} followed."
    redirect_to @user
  end

  def destroy
    @user = Relationship.find(params[:id]).followed
    current_user.unfollow!(@user)
    flash[:notice] = "#{@user.username} unfollowed."
    redirect_to @user
  end

end
