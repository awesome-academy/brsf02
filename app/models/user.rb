class User < ApplicationRecord
  before_save :downcase_email
  enum role: {user: 0, admin: 1}
  has_many :book_favorites, dependent: :destroy
  has_many :book_statuses, dependent: :destroy
  has_many :reading_statuses, -> { where status: "reading" }, class_name: :BookStatus
  has_many :reading_books, through: :reading_statuses, source: :book
  has_many :as_read_statuses, -> { where status: "as_read"}, class_name: :BookStatus
  has_many :as_read_books, through: :as_read_statuses, source: :book
  has_many :reviews, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_activities, through: :likes, source: :activity
  has_many :suggests, dependent: :destroy
  has_many :activities, dependent: :destroy
  has_many :active_relationships, class_name:  Relationship.name,
    foreign_key: :follower_id, dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :passive_relationships, class_name:  Relationship.name,
    foreign_key: :followed_id, dependent: :destroy
  has_many :followers, through: :passive_relationships, source: :follower
  has_many :marked_books, through: :book_statuses, source: :book
  has_many :favorite_books, through: :book_favorites, source: :book
  scope :newest, ->{order created_at: :desc}

  mount_uploader :avatar, AvatarUploader
  attr_accessor :remember_token

  has_secure_password
  validates :password, presence: true,
  length: {minimum: Settings.users.password.min_length}, allow_nil: true
  before_save{email.downcase!}

  validates :name, presence: true,
  length: {maximum: Settings.users.name.max_length}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  validates :email, presence: true,
  length: {maximum: Settings.users.name.max_length},
  format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}

  # Returns the hash digest of the given string.
  def self.digest string
    if cost = ActiveModel::SecurePassword.min_cost
      BCrypt::Engine::MIN_COST
    else
      BCrypt::Engine.cost
    end
    BCrypt::Password.create string, cost: cost
  end

  # Follows a user.
  def follow(other_user)
    following << other_user
  end

  # Unfollows a user.
  def unfollow(other_user)
    following.delete(other_user)
  end

  # Returns true if the current user is following the other user.
  def following?(other_user)
    following.include?(other_user)
  end

  def liked?(activity)
    liked_activities.include?(activity)
  end

  # Returns a random token.
  def self.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = User.new_token
    update_attribute :remember_digest, User.digest(remember_token)
  end

  def forget
    update_attribute :remember_digest, nil
  end

  def authenticated? attribute, token
    digest = send "#{attribute}_digest"
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password? token
  end

  def feed
    following_ids = "SELECT followed_id FROM relationships
      WHERE  follower_id = :user_id"
    Activity.where("user_id IN (#{following_ids})
      OR user_id = :user_id", user_id: id)
  end

  private

    def downcase_email
      email.downcase!
    end
end
