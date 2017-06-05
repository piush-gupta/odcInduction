class AddStatusToTasks < ActiveRecord::Migration
  def up
    add_column :tasks, :status, :boolean, default: true
  end

  def down
    remove_column :tasks, :status
  end
end
