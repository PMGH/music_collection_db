require_relative('../db/sql_runner')


class Album

  attr_accessor :artist_id, :title, :genre
  attr_reader :id

  # Create and Save Albums
  # Every artist should have a name, and each album should have a name/title, genre and artist ID.
  def initialize(options)
    @id = options['id'].to_i if options['id']
    @artist_id = options['artist_id'].to_i
    @title = options['title']
    @genre = options['genre']
  end

  def save()
    # sql
    sql = "INSERT INTO albums (
    artist_id, title, genre
    )
    VALUES (
      $1, $2, $3
    )
    RETURNING id;
    "
    # values
    values = [@artist_id, @title, @genre]
    # sql runner
    results = SqlRunner.run(sql, "save_album", values)
    # set id equal to the id of the zeroth item (hash) of the returned array
    @id = results[0]['id'].to_i
  end

  def self.delete_all()
    # sql
    sql = "DELETE FROM albums;"
    # values
    values = []
    # sql runner
    SqlRunner.run(sql, "delete_all_albums", values)
  end

  # List All Artists/Albums
  def self.all()
    sql = "SELECT * FROM albums;"
    values = []
    results = SqlRunner.run(sql, "get_albums", values)
    return results.map { |album| Album.new(album) }
  end

  # Show the artist any album belongs to
  def artist()
    sql = "SELECT * FROM artists WHERE id = $1;"
    values = [@artist_id]
    results = SqlRunner.run(sql, "get_artist", values)
    return results.map { |artist| Artist.new(artist) }
  end

end
