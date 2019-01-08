module SessionsHelper
  def log_in user
    session[:user_id] = user.id
  end

  def remember user
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  def current_user
    if  user_id = session[:user_id]
      @current_user ||= User.find_by id: user_id
    elsif  user_id = cookies.signed[:user_id]
      user = User.find_by id: user_id
      if user&.authenticate params[:session][:password]
        log_in user
        @current_user = user
      end
    end
  end

  def login_user
    log_in @user
    if params[:session][:remember_me] == Settings.users.remember.chosen?
      remember @user
    else
      forget @user
    end
    redirect_to @user
  end

  def forget user
    user.forget
    cookies.delete :user_id
    cookies.delete :remember_token
  end

  def log_out
    forget current_user
    session.delete :user_id
    @current_user = nil
  end

  def logged_in?
    current_user.present?
  end
end