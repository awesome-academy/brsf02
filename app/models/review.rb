class Review < ApplicationRecord
  after_save :create_activity
  belongs_to :user
  belongs_to :book
  has_one :activity, as: :object, dependent: :destroy
  validates :stars, presence: true, numericality: { only_integer: true, less_than_or_equal_to: 5 }
  validates :title, presence: true,
    length: {maximum: Settings.reviews.title.max_length}
  scope :newest, ->{order created_at: :desc}
  private

    def create_activity
      self.user.activities.build(object: self).save
    end
end
