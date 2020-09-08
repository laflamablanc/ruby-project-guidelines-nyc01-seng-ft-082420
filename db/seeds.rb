
20.times do
  Song.create(
    [{name:Faker::Music.name,
      genre:Faker::Music.genre}]
  )
end
