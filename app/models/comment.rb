class Comment < ApplicationRecord
  belongs_to :user
  has_one :activity, as: :object, dependent: :destroy
  belongs_to :parent_activity, class_name: Activity.name,
    foreign_key: :parent_id
  validates :content, presence: true,
    length: {maximum: Settings.comments.content.max_length}
  scope :newest, ->{order created_at: :desc}
  private

    def create_activity
      self.user.activities.build(object: self).save
    end
end
