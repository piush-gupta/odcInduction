class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.references :user, index: true
      t.string :title
      t.text :details
      t.date :deadline
      t.timestamps
    end
  end
end
