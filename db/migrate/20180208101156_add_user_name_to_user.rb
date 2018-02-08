class AddUserNameToUser < ActiveRecord::Migration[5.1]
  def up
    add_column :users, :user_name, :string
    User.all.each do |user|
      user.update(user_name: "#{user.first_name}_#{user.last_name}_#{user.id}")
    end
  end

  def down
    remove_columns :users, :user_name
  end
end
