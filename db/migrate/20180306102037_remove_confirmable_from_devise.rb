class RemoveConfirmableFromDevise < ActiveRecord::Migration[5.1]
  def change
    remove_columns :users, :confirmation_token, :confirmed_at, :confirmation_sent_at
  end
end
