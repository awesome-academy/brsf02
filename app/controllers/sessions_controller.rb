class SessionsController < ApplicationController
  def new
    redirect_to root_path if logged_in?
  end

  def create
    @user = User.find_by email: params[:session][:email].downcase
    if @user&.authenticate params[:session][:password]
      login_user
      redirect_back_or @user
    else
      flash.now[:danger] = t "flash.login_error"
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_path
  end
end
