
5.times do
  Song.create(
    [{name:Faker::Music::GratefulDead.song,
      genre:Faker::Music.genre}]
  )
end
5.times do
  Song.create(
    [{name:Faker::Music::PearlJam.song,
      genre:Faker::Music.genre}]
  )
end
5.times do
  Song.create(
    [{name:Faker::Music::Prince.song,
      genre:Faker::Music.genre}]
  )
end
5.times do
  Song.create(
    [{name:Faker::Music::UmphreysMcgee.song,
      genre:Faker::Music.genre}]
  )
end

user1 = User.create(name: "User1")
user2 = User.create(name: "User2")

song1 = Song.all[0]
song2 = Song.all[1]
song3 = Song.all[3]

default_playlist = Playlist.create(name: "default_playlist", mood: "Happy", creator_id: user1.id)
user1.add_song(song: song1, playlist:default_playlist)
user1.add_song(song: song2, playlist:default_playlist)
user1.add_song(song: song3, playlist:default_playlist)
