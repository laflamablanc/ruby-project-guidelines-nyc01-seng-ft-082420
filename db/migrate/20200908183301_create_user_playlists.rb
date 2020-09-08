class CreateUserPlaylists < ActiveRecord::Migration[6.0]
  def change
    create_table :user_playlists do |t|
      t.integer :user_id
      t.integer :playlist_id
      t.float :rating
    end
  end
end
