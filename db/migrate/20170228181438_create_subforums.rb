class CreateSubforums < ActiveRecord::Migration[5.0]
  def change
    create_table :subforums do |t|
      t.string :title, null: false
      t.text :description
      t.integer :moderator_id, null: false

      t.timestamps
    end

    add_index :subforums, :moderator_id
  end
end
