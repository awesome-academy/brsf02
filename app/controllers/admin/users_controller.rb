class Admin::UsersController < AdminController
  layout "admin"
  before_action :load_user, except: [:index]

  def index
    @users = User.newest.paginate page: params[:page],
      per_page: Settings.users.index.per_page
  end

  def destroy
    if @user.destroy
      flash[:success] = t "flash.deleted"
    else
      flash[:danger] = t "flash.delete_fail"
    end
    redirect_to admin_users_path
  end

  private

  def load_user
    @user = User.find_by id: params[:id]
    return if @user
    flash[:danger] = t "flash.nouser"
    redirect_to admin_users_path
  end
end
