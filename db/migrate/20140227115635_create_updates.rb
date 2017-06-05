class CreateUpdates < ActiveRecord::Migration
  def change
    create_table :updates do |t|
      t.text :content
      t.integer :user_id

      t.timestamps
    end
    add_index :updates, [:user_id, :created_at]
  end
end
