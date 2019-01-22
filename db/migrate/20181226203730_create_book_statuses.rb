class CreateBookStatuses < ActiveRecord::Migration[5.1]
  def change
    create_table :book_statuses do |t|
      t.references :user, foreign_key: true
      t.references :book, foreign_key: true
      t.integer :status, null: false, default: 0
      t.timestamps
    end
    add_index :book_statuses, [:user_id, :created_at]
    add_index :book_statuses, [:book_id, :created_at]
    add_index :book_statuses, [:book_id, :user_id], unique: true
  end
end
