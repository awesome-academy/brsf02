class BooksController < ApplicationController
  before_action :load_book, except: [:index, :new, :create]
  before_action :logged_in_user

  def show; end

  def index
    @books = Book.search(search_params,current_user).paginate page: params[:page],
      per_page: Settings.books_index.perpage
    @book_statuses = current_user.book_statuses.where(book_id: @books.ids)
    @book_favorites = current_user.book_favorites.where(book_id: @books.ids)
  end

  private

  def load_book
    @book = Book.find_by id: params[:id]
    return if @book
    flash[:danger] = t "flash.nobook"
    redirect_to admin_books_path
  end

  def search_params
    params.permit(:title, :category_id, :author,:status)
  end
end
