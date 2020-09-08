
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
