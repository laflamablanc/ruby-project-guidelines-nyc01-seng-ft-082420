class Song < ActiveRecord::Base
  has_many :playlist_songs
  has_many :playlists, through: :playlists_songs
end
