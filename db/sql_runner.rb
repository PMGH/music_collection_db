require('pg')

class SqlRunner

  def self.run(sql, tag, values)
    # connect
    db = PG.connect({ dbname: 'music', host: 'localhost' })
    # prepare db for sql
    db.prepare(tag, sql)
    # run sql (with subbed values) on db
    results = db.exec_prepared(tag, values)
    # close db connection
    db.close
    # return
    return results if results
  end

end
