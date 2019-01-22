class UsersController < ApplicationController
  before_action :logged_in_user, except: [:show, :new, :create]
  before_action :load_user, except: [:index, :new, :create]
  before_action :correct_user, only: [:edit, :update]

  def show
    @activities = @user.activities.includes(:object, :likes).includes(comments: [:user]).paginate page: params[:page],
      per_page: Settings.users.index.per_page
    @favorite_books = @user.favorite_books
  end

  def index
    @users = User.newest.paginate page: params[:page],
      per_page: Settings.users.index.per_page
  end

  def edit; end

  def update
    if @user.update_attributes user_params
      flash[:success] = t "flash.updated"
      redirect_to @user
    else
      render :edit
    end
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
end
