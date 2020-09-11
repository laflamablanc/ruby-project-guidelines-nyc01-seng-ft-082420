class User < ActiveRecord::Base
  has_many :user_playlists
  has_many :playlists, through: :user_playlists

  def create_playlist(name:, mood:)
    #puts "name:"
    #name = gets.chomp
    #puts "type:"
    #type = gets.chomp
    playlist = Playlist.create(name: name, mood: mood, creator_id: self.id)
    UserPlaylist.create(user: self, playlist: playlist)
    playlist
  end

  def add_song(song:, playlist:)
    if playlist.creator_id == self.id
      PlaylistSong.find_or_create_by(song: song, playlist: playlist)
    else
      puts "This isn't your playlist!"
    end
  end

  def remove_song(song:, playlist:)
    if playlist.creator_id == self.id
      if PlaylistSong.find_by(song: song, playlist: playlist) != nil
        PlaylistSong.find_by(song: song, playlist: playlist).delete
      else
        puts "Song not found"
      end
    else
      puts "This isn't your playlist!"
    end
  end

  def delete_playlist(playlist:)
    if playlist.creator_id == self.id
      all_ps = PlaylistSong.all.filter{|ps| ps.playlist == playlist}
      all_ps.each{|ps| ps.delete}
      playlist.delete
    else
      puts "This isn't your playlist!"
    end
  end

  def rate_playlist(playlist:, rating:)
    up = UserPlaylist.find_or_create_by(user: self, playlist: playlist)
    up.rating = rating
    up.save
  end

end
