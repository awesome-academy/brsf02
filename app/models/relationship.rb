class Relationship < ApplicationRecord
  after_save :create_activity
  belongs_to :follower, class_name: User.name
  belongs_to :followed, class_name: User.name
  has_many :activities, as: :object, dependent: :destroy
  validates :follower_id, presence: true
  validates :followed_id, presence: true

  private

    def create_activity
      self.follower.activities.build(object: self).save
      self.followed.activities.build(object: self).save
    end
end
