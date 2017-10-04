require('pry-byebug')
require_relative('../models/artist')
require_relative('../models/album')


# Albums references Artist so is deleted first
Album.delete_all()
Artist.delete_all()


artist1 = Artist.new(
  {
    'name' => 'Alice In Chains'
  }
)
artist1.save()

album1 = Album.new(
  {
    'artist_id' => artist1.id,
    'title' => 'Black Gives Way To Blue',
    'genre' => 'Grunge'
  }
)
album1.save()


artist2 = Artist.new(
  {
    'name' => 'Led Zeppelin'
  }
)
artist2.save()

album2 = Album.new(
  {
    'artist_id' => artist2.id,
    'title' => 'Mothership (Remastered)',
    'genre' => 'Rock'
  }
)
album2.save()

album3 = Album.new(
  {
    'artist_id' => artist1.id,
    'title' => 'Unplugged',
    'genre' => 'Grunge'
  }
)
album3.save()

artist1.name = "Flintstones"
artist1.update()

album2.delete()
artist2.delete()

binding.pry
nil
