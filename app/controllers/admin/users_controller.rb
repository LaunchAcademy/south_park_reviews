module Admin
  class UsersController < BaseController
    def destroy
      user = User.find(params[:id])
      user.destroy
      flash[:notice] = "User has been deleted"
      redirect_to root_path
    end

    def update
      user = User.find(params[:id])
      user.role = params[:role]
      user.save
      flash[:notice] = "User has been set as Admin"
      redirect_to root_path
    end
  end
end
