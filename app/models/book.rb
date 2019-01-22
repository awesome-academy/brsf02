class Book < ApplicationRecord
  belongs_to :category
  mount_uploader :picture, PictureUploader
  has_many :reviews, dependent: :destroy
  has_many :book_statuses, dependent: :destroy
  has_many :favorite_books, dependent: :destroy
  validates :title, presence: true,
    length: {maximum: Settings.books.title.max_length}
  validates :author, presence: true,
    length: {maximum: Settings.books.author.max_length}
  validates :pages_count, presence: true,
    numericality: { only_integer: true, less_than_or_equal_to: 2000, more_than: 0 }
  validate  :picture_size
  scope :title_contains, ->(title){where "title LIKE ?", "%#{title}%"}
  scope :author_contains, ->(author){where "author LIKE ?", "%#{author}%"}
  scope :category_id_is, ->(category_id){where "category_id LIKE ?", category_id}

  def self.search search, current_user
    if search
        results = current_user.reading_books if search[:status] == "reading"
        results = current_user.as_read_books if search[:status] == "as_read"
        if results.nil?
        results = self.title_contains(search[:title]).author_contains search[:author]
        else
        results = results.title_contains(search[:title]).author_contains search[:author]
        end
        results = results.category_id_is(search[:category_id]) if search[:category_id].present?
        results
    else
      where(nil)
    end
  end


  private

    # Validates the size of an uploaded picture.
    def picture_size
      if picture.size > 5.megabytes
        errors.add :picture, t("errors.picture_size")
      end
    end
end
