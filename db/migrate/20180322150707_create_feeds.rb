class CreateFeeds < ActiveRecord::Migration[5.1]
  def change
    create_table :feeds do |t|
      t.integer :user_id
      t.integer :album_id
      t.integer :photo_ids, array: true, default: []
      t.timestamps
    end
  end
end
