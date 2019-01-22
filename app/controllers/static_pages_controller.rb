class StaticPagesController < ApplicationController
  def home
    return unless logged_in?
    @activities = current_user.feed.includes(:object).includes(comments: [:user]).includes(likes: [:user]).includes(:user).newest.paginate(page: params[:page])
  end

  def about; end

  def contact; end
end
