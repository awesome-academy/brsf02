class CreateReviews < ActiveRecord::Migration[5.1]
  def change
    create_table :reviews do |t|
      t.text :title
      t.text :content
      t.integer :stars
      t.references :user, foreign_key: true
      t.references :book, foreign_key: true
      t.timestamps
    end
    add_index :reviews, [:user_id, :created_at]
    add_index :reviews, [:book_id, :created_at]
  end
end
