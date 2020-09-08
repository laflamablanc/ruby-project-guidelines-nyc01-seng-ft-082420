class Playlist < ActiveRecord::Base
  has_many :playlist_songs
  has_many :songs, through: :playlist_songs
  has_many :user_playlists
  has_many :users, through: :user_playlists

  def average_rating
    userplaylist = UserPlaylists.all.filter{|up| up.playlist == self}
    avg = userplaylist.sum{|up| up.rating}/userplaylist.count
    avg
  end


end
