class AddColumnToUsers < ActiveRecord::Migration
  def change
    add_column :users, :name, :string
    add_column :users, :emp_id, :integer
    add_column :users, :phn_no, :integer
    add_column :users, :card_no, :integer
    add_column :users, :location, :string
    add_column :users, :address, :string
    add_column :users, :technology, :string
    add_column :users, :experience, :integer
  end
end
