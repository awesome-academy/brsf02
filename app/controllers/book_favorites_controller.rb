class BookFavoritesController < ApplicationController
  before_action :load_book_favorite, only: :destroy
  before_action :logged_in_user
  before_action :correct_user, only: :destroy
  def create
    @book_favorite =  current_user.book_favorites.build book_favorite_params
    if @book_favorite.save
      respond_to do |format|
        format.html { redirect_to books_path }
        format.js
      end
    else
      flash[:danger] = t "flash.nobook"
      redirect_to books_path
    end
  end


  def destroy
    @book = @book_favorite.book
    if @book_favorite.destroy
        respond_to do |format|
          format.html { redirect_to @book_favorite.book }
          format.js
        end
    else
      flash[:danger] = t "flash.nobook"
      redirect_to root_path
    end
  end

  private

  def book_favorite_params
    params.permit(:book_id)
  end

  def load_book_favorite
    @book_favorite =  BookFavorite.find_by id: params[:id]
  end

  def correct_user
    return if current_user == @book_favorite.user
    redirect_to(books_path)
    flash[:danger] = t "flash.wronguser"
  end
end
