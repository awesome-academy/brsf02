class Category < ApplicationRecord
  has_many :books, dependent: :destroy
  scope :ordered_by_name, -> { order(name: :asc) }
  validates :name, presence: true,
    length: {maximum: Settings.categories.name.max_length}
end
