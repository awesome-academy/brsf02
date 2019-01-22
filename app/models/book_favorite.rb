class BookFavorite < ApplicationRecord
  after_save :create_activity
  belongs_to :user
  belongs_to :book
  has_one :activity, as: :object, dependent: :destroy
  private

    def create_activity
      self.user.activities.build(object: self).save
    end
end
