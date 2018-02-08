class AddUserNameToUser < ActiveRecord::Migration[5.1]
  def up
    add_column :users, :user_name, :string
  end

  def down
    remove_columns :users, :user_name
  end
end
