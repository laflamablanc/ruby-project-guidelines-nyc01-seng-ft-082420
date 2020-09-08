class User < ActiveRecord::Base
  has_many :user_playlists
  has_many :playlists, through: :user_playlists

  def create_playlist
    #puts "name:"
    #name = gets.chomp
    name = "Playlist"
    #puts "type:"
    #type = gets.chomp
    type1 = "Type 1"
    playlist = Playlist.create(name: name, mood: type1, creator_id: self.id)
    UserPlaylist.create(user: self, playlist: playlist)
  end

  def add_song(song:, playlist:)
    if playlist.creator_id == self.id
      PlaylistSongs.find_or_create_by(song: song, playlist: playlist)
    else
      puts "This isn't your playlist!"
    end
  end

  def remove_song(song:, playlist:)
    if playlist.creator_id == self.id
      if PlaylistSongs.find_by(song: song, playlist: playlist) != nil
        PlaylistSongs.find_by(song: song, playlist: playlist).delete
      else
        puts "Song not found"
      end
    else
      puts "This isn't your playlist!"
    end
  end

  def delete_playlist(playlist)
    if playlist.creator_id == self.id
      all_ps = PlaylistSongs.all.filter{|ps| ps.playlist == playlist}
      all_ps.each{|ps| ps.delete}
      playlist.delete
    else
      puts "This isn't your playlist!"
    end
  end

end
