class CreateBookFavorites < ActiveRecord::Migration[5.1]
  def change
    create_table :book_favorites do |t|
      t.references :user, foreign_key: true
      t.references :book, foreign_key: true
      t.integer :status, null: false, default: 0
      t.timestamps
    end
    add_index :book_favorites, [:user_id, :created_at]
    add_index :book_favorites, [:book_id, :created_at]
  end
end
