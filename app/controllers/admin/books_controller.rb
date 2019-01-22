class Admin::BooksController < AdminController
  layout "admin"
  before_action :load_book, except: [:index, :new, :create]

  def destroy
    if @book.destroy
      flash[:success] = t "flash.deleted"
    else
      flash[:danger] = t "flash.error"
    end
    redirect_to admin_books_path
  end

  def edit; end

  def update
    if @book.update_attributes book_params
      flash[:success] = t "flash.updated"
      redirect_to admin_books_path
    else
      render :edit
    end
  end

  def index
    @books = Book.paginate page: params[:page],
      per_page: Settings.books_index.per_page
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new book_params
    if @book.save
      flash[:success] = t "flash.created"
      redirect_to admin_books_path
    else
      render :new
    end
  end

  private

  def book_params
    params.require(:book).permit(:title, :author, :category_id, :publish_date,
      :pages_count, :picture)
  end

  def load_book
    @book = Book.find_by id: params[:id]
    return if @book
    flash[:danger] = t "flash.nobook"
    redirect_to admin_books_path
  end
end
