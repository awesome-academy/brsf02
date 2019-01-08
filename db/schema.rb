# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20181230161315) do

  create_table "activities", force: :cascade do |t|
    t.string "object_type"
    t.integer "object_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["object_type", "object_id"], name: "index_activities_on_object_type_and_object_id"
  end

  create_table "book_statuses", force: :cascade do |t|
    t.integer "user_id"
    t.integer "book_id"
    t.integer "status", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["book_id", "created_at"], name: "index_book_statuses_on_book_id_and_created_at"
    t.index ["book_id"], name: "index_book_statuses_on_book_id"
    t.index ["user_id", "created_at"], name: "index_book_statuses_on_user_id_and_created_at"
    t.index ["user_id"], name: "index_book_statuses_on_user_id"
  end

  create_table "books", force: :cascade do |t|
    t.text "title"
    t.date "publish_date"
    t.text "author"
    t.integer "pages_count"
    t.integer "category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_books_on_category_id"
  end

  create_table "categories", force: :cascade do |t|
    t.text "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "comments", force: :cascade do |t|
    t.text "content"
    t.integer "user_id"
    t.integer "parent_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "created_at"], name: "index_comments_on_user_id_and_created_at"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "favorite_books", force: :cascade do |t|
    t.integer "user_id"
    t.integer "book_id"
    t.integer "status", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["book_id", "created_at"], name: "index_favorite_books_on_book_id_and_created_at"
    t.index ["book_id"], name: "index_favorite_books_on_book_id"
    t.index ["user_id", "created_at"], name: "index_favorite_books_on_user_id_and_created_at"
    t.index ["user_id"], name: "index_favorite_books_on_user_id"
  end

  create_table "likes", force: :cascade do |t|
    t.integer "user_id"
    t.integer "activity_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["activity_id"], name: "index_likes_on_activity_id"
    t.index ["user_id"], name: "index_likes_on_user_id"
  end

  create_table "rates", force: :cascade do |t|
    t.integer "stars", default: 0, null: false
    t.integer "user_id"
    t.integer "book_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["book_id"], name: "index_rates_on_book_id"
    t.index ["user_id", "book_id"], name: "index_rates_on_user_id_and_book_id"
    t.index ["user_id"], name: "index_rates_on_user_id"
  end

  create_table "relationships", force: :cascade do |t|
    t.integer "follower_id"
    t.integer "followed_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["followed_id"], name: "index_relationships_on_followed_id"
    t.index ["follower_id", "followed_id"], name: "index_relationships_on_follower_id_and_followed_id", unique: true
    t.index ["follower_id"], name: "index_relationships_on_follower_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.text "title"
    t.text "content"
    t.integer "user_id"
    t.integer "book_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["book_id", "created_at"], name: "index_reviews_on_book_id_and_created_at"
    t.index ["book_id"], name: "index_reviews_on_book_id"
    t.index ["user_id", "created_at"], name: "index_reviews_on_user_id_and_created_at"
    t.index ["user_id"], name: "index_reviews_on_user_id"
  end

  create_table "suggests", force: :cascade do |t|
    t.integer "user_id"
    t.integer "status", default: 0, null: false
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_suggests_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.integer "role", default: 0, null: false
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "activation_digest"
    t.boolean "activated", default: false
    t.datetime "activated_at"
    t.string "remember_digest"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

end
