class CreateAlbums < ActiveRecord::Migration[5.1]
  def change
    create_table :albums do |t|
      t.string :name
      t.text :description
      t.integer :user_id
      t.integer :private
      t.timestamps
    end
  end
end
