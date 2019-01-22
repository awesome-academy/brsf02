class Activity < ApplicationRecord
  belongs_to :object, polymorphic: true
  belongs_to :user
  has_many :comments, -> {newest} , class_name:  Comment.name,
    foreign_key: :parent_id, dependent: :destroy
  has_many :likes, dependent: :destroy
  scope :newest, ->{order created_at: :desc}
end
