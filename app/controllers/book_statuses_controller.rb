class BookStatusesController < ApplicationController
  before_action :load_book_status, except: :create
  before_action :logged_in_user
  before_action :correct_user, except: :create
  def create
    @book_status =  current_user.book_statuses.build book_status_params
    if @book_status.save
      respond_to do |format|
        format.html { redirect_to books_path }
        format.js
      end
    else
      flash[:danger] = t "flash.nobook"
      redirect_to books_path
    end
  end

  def update
    if @book_status.update_attributes book_status_params
      respond_to do |format|
        format.html { redirect_to @book_status.book }
        format.js
      end
    else
      flash[:danger] = t "flash.nobook"
      redirect_to root_path
    end
  end

  def destroy
    @book = @book_status.book
    if @book_status.destroy
        respond_to do |format|
          format.html { redirect_to @book_status.book }
          format.js
        end
    else
      flash[:danger] = t "flash.nobook"
      redirect_to root_path
    end
  end

  private

  def book_status_params
    params.require(:book_status).permit :book_id, :status
  end

  def load_book_status
    @book_status = BookStatus.find_by id: params[:id]
    return if @book_status
    redirect_to books_path
    flash[:danger] = t "flash.wronguser"
  end

  def correct_user
    return if current_user == @book_status.user
    redirect_to books_path
    flash[:danger] = t "flash.wronguser"
  end
end
