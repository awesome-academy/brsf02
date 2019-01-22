module BooksHelper
  def load_book_status(book)
    @book_status = @book_statuses.select{|status| status.book_id == book.id}.first
    if @book_status.nil?
      @book_status = BookStatus.new
    end
  end

  def load_book_favorite(book)
    @book_favorite = @book_favorites.select{|favorite| favorite.book_id == book.id}.first
    if @book_favorite.nil?
      @book_favorite = BookFavorite.new
    end
  end
end
