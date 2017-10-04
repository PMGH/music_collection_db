require_relative('../db/sql_runner')


class Artist

  # Edit Artists/Albums
  attr_accessor :name
  attr_reader :id

  # Create and Save Artists
  # Every artist should have a name, and each album should have a name/title, genre and artist ID.
  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
  end

  def save()
    # sql
    sql = "INSERT INTO artists (
    name
    )
    VALUES (
      $1
    )
    RETURNING id;
    "
    # values
    values = [@name]
    # sql runner
    results = SqlRunner.run(sql, "save_artist", values)

    @id = results[0]['id'].to_i
  end

  def self.delete_all()
    # sql
    sql = "DELETE FROM artists;"
    # values
    values = []
    # sql runner
    SqlRunner.run(sql, "delete_all_artists", values)
  end

  # List All Artists/Albums
  def self.all()
    # sql
    sql = "SELECT * FROM artists;"
    # values
    values = []
    # sql runner
    results = SqlRunner.run(sql, "get_artists", values)
    # return
    return results.map { |artist| Artist.new(artist) }
  end

  # List all the albums they have by an artist
  def albums()
    # sql
    sql = "SELECT * FROM albums WHERE artist_id = $1;"
    # values
    values = [@id]
    # sql runner
    results = SqlRunner.run(sql, "get_albums", values)
    # return
    return results.map { |album| Album.new(album) }
  end

  # Edit Artists/Albums
  def update()
    # sql
    sql = "UPDATE artists SET (
    name
    ) = (
      $1
      )
      WHERE id = $2;"
    # values
    values = [@name, @id]
    # sql runner
    SqlRunner.run(sql, "update_artist", values)
  end

end
