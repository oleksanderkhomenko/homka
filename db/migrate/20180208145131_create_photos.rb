class CreatePhotos < ActiveRecord::Migration[5.1]
  def change
    create_table :photos do |t|
      t.integer :user_id
      t.integer :album_id
      t.string :name
      t.string :image
      t.text :description
      t.timestamps
    end
  end
end
