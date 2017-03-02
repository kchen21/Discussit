class CreatePosts < ActiveRecord::Migration[5.0]
  def change
    create_table :posts do |t|
      t.string :title, null: false
      t.string :url
      t.text :body, null: false
      t.integer :subforum_id, null: false
      t.integer :author_id, null: false

      t.timestamps
    end

    add_index :posts, :subforum_id
    add_index :posts, :author_id
    add_index :posts, :title, unique: true
    add_index :subforums, :title, unique: true
  end
end
