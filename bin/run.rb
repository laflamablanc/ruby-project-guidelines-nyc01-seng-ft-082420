require_relative '../config/environment.rb'
require "tty-prompt"
require "pry"

prompt = TTY::Prompt.new
user = User.all[0]

if user != nil
  choices = ("Create Playlist,See All Existing Playlists,See All Songs,Rate an Existing Playlist,Edit One of my Playlists,Delete Playlist,Exit" ).split(",")
  selection = ""
  until selection == "Exit" do
  selection = prompt.enum_select("What would you like to do? (Choose 7 to exit)", choices)
    if selection == "Create Playlist"
      name = prompt.ask("Playlist name?")
      mood = prompt.select("Playlist mood?", %w(Happy Sad Workout Party))
      playlist = user.create_playlist(name:name, mood:mood)
      add_or_not = prompt.yes?("Do you want to add songs to it?")
      if add_or_not == true
        song_get = prompt.ask("What's the song name?")
        find_song = Song.all.find{|song| song.name == song_get}
        if find_song != nil
          user.add_song(song: find_song, playlist: playlist)
        else
          puts "This song is not found"
        end
      end
    elsif selection == "See All Existing Playlists"
      if Playlist.all != []
        playlist_choices = Playlist.all.map{|pl| pl.name }
        playlist_selection = prompt.select("Select the playlist", playlist_choices)
        playlist = Playlist.all.find{|pl| pl.name ==  playlist_selection}
        playlist.songs.each{|song| puts "#{song.name}\n"}
      else
        puts "No playlist available"
      end
    elsif selection == "See All Songs"
      if Song.all != []
        p Song.all.map{|song| song.name }
      else
        puts "No song found"
      end

    elsif selection == "Rate an Existing Playlist"
      name = prompt.ask("What is the name of the playlist?")
      rating = prompt.ask("How much do you want to rate (1-5)?")
      if Playlist.all != []
        playlist = Playlist.all.find{|pl| pl.name == name}
        user.rate_playlist(rating: rating, playlist:playlist)
      else
        puts "No playlist available"
      end

    elsif selection == "Edit One of my Playlists"
      choice = user.playlists.map{|pl| pl.name}
      playlist_name = prompt.enum_select("Which playlist", choice)
      playlist = Playlist.all.find{|pl| pl.name == playlist_name}
      songs = playlist.songs.map do |song|
        #"#{song.artist} - #{song.name}"
        song.name
      end
      add_remove = prompt.select("add/remove", %w(add remove))
      if add_remove == "add"
        song_get = prompt.ask("What's the song name?")
        find_song = Song.all.find{|song| song.name == song_get}
        if find_song != nil
          user.add_song(song: find_song, playlist: playlist)
        else
          puts "This song is not found"
        end
      else
        song_get = prompt.ask("What's the song name?")
        find_song = Song.all.find{|song| song.name == song_get}
        if find_song != nil
          user.remove_song(song: find_song, playlist: playlist)
        else
          puts "This song is not found"
        end
      end

    elsif selection == "Delete Playlist"
      if Playlist.all != []
        choice = user.playlists.map{|pl| pl.name}
        playlist_select = prompt.enum_select("Which playlist", choice)
        playlist = Playlist.all.find{|pl| pl.name == playlist_select}
        user.delete_playlist(playlist: playlist)
      else
        puts "No playlist available"
      end
    end
  end

else
  puts "User not found!"
end
