class CreateSongs < ActiveRecord::Migration
  def change
    create_table :songs do |t|
      t.string :title
      t.string :artist
      t.text :path
      t.integer :user_id
      t.integer :playlist_id

      t.timestamps
    end
  end
end
