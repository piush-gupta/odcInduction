class AddTaskAndUpdateAssociation < ActiveRecord::Migration
  def change
  	create_table :tasks_updates, id: false do |t|
  		t.belongs_to :task
  		t.belongs_to :update
  	end
  end
end
