class UsersController < ApplicationController
  before_action :logged_in_user, except: [:show, :new, :create]
  before_action :load_user, except: [:index, :new, :create]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy

  def show; end

  def index
    @users = User.newest.paginate page: params[:page],
      per_page: Settings.users.index.per_page
  end

  def edit; end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = t "flash.updated"
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t "flash.deleted"
    else
      flash[:danger] = t "flash.delete_fail"
    end
    redirect_to users_path
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      log_in @user
      flash[:success] = t "flash.welcome"
      redirect_to @user
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit :name, :email, :password,
      :password_confirmation, :avatar
  end

  def logged_in_user
    return if logged_in?
    store_location
    flash[:danger] = t "flash.notlogin"
    redirect_to login_path
  end

  def load_user
    @user = User.find_by id: params[:id]
    return if @user
    flash[:danger] = t "flash.nouser"
    redirect_to root_path
  end

  def correct_user
    return if current_user == @user
    redirect_to(root_path)
    flash[:danger] = t "flash.wronguser"
  end

  def admin_user
    redirect_to(root_path) unless current_user.admin?
  end
end
