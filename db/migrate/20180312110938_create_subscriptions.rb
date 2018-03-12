class CreateSubscriptions < ActiveRecord::Migration[5.1]
  def change
    create_table :subscriptions do |t|
      t.integer :follower_id
      t.integer :idol_id
      t.timestamps
    end
  end
end
