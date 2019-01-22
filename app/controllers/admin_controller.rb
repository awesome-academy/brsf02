class AdminController < ApplicationController
  before_action :logged_in_user, :admin_user

  def admin_user
    redirect_to(root_path) unless current_user.admin?
  end
end
