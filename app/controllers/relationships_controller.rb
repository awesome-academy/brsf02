class RelationshipsController < ApplicationController
  before_action :logged_in_user
  before_action :load_relationship,  only: :destroy
  before_action :correct_user,  only: :destroy
  def create
    @user = User.find_by id: params[:followed_id]
    current_user.follow @user
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end

  def destroy
    @user = @relationship.followed
    Relationship.find_by(id: params[:id]).destroy
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end

  private

  def load_relationship
    @relationship = Relationship.find_by id: params[:id]
    return if @relationship
    redirect_to root_path
    flash[:danger] = t "flash.error"
  end

  def correct_user
    return if current_user? @relationship.follower
    flash[:danger] = t "flash.wronguser"
    redirect_to root_path
  end
end
