class AdminController < ApplicationController
  before_action :admin_user

  def index
    @users = User.all
  end

  def destroy
    user = User.find(params[:id])
    if current_user != user
      user.destroy
      flash[:success] = "User deleted"
    else
      flash[:alert] = "Can't delete your own account"
    end
    redirect_to dashboard_url
  end

  def role_change
    user = User.find(params[:id])
    if current_user != user
      user.update_attributes(isAdmin: !user.isAdmin)
      user.save
      flash[:success] = "Role changed"
    else
      flash[:alert] = "Can't remove your own role"
    end
    redirect_to(dashboard_path)
  end

  def admin_user
      redirect_to(root_url) unless user_signed_in? && current_user.isAdmin?
  end
end
