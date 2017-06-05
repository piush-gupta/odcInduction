class AddFirstLoginTokenToUsers < ActiveRecord::Migration
  def up
    add_column :users, :first_login_token, :string, default: nil
  end

  def down
    remove_column :users, :first_login_token
  end
end
