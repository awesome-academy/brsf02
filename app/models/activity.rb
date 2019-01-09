class Activity < ApplicationRecord
  belongs_to :object, polymorphic: true
  belongs_to :user
  has_many :comments, class_name:  Comment.name,
    foreign_key: :parent_id, dependent: :destroy
  has_many :likes, dependent: :destroy
end
