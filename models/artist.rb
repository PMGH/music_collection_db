require_relative('../db/sql_runner')


class Artist

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
    sql = "SELECT * FROM artists;"
    values = []
    results = SqlRunner.run(sql, "get_artists", values)
    return results.map { |artist| Artist.new(artist) }
  end

  # List all the albums they have by an artist
  def albums()
    sql = "SELECT * FROM albums WHERE id = $1;"
    values = [@id]
    results = SqlRunner.run(sql, "get_albums", values)
    return results.map { |album| Album.new(album) }
  end

end
