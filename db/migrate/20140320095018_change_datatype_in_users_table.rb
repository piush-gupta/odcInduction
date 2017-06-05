class ChangeDatatypeInUsersTable < ActiveRecord::Migration
  def change
  	change_column :users, :phn_no, :string
  end
end
