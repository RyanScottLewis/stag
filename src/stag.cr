require "sqlite3"
require "crecto"

require "./stag/repository"
require "./stag/model/tag"
require "./stag/model/link"
require "./stag/model/union"

DB.open(Stag::Repository.config.database_url) do |db|

  db.exec <<-SQL
    CREATE TABLE IF NOT EXISTS links (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL,
      path TEXT NOT NULL
    );
  SQL

  db.exec <<-SQL
    CREATE TABLE IF NOT EXISTS tags (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL,
      path TEXT NOT NULL,
      level INTEGER NOT NULL
    );
  SQL

  db.exec <<-SQL
    CREATE TABLE IF NOT EXISTS unions (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      link_id INTEGER NOT NULL,
      tag_id INTEGER NOT NULL
    );
  SQL

end

Query = Crecto::Repo::Query

link = Stag::Repository.get!(Stag::Model::Link, 1, Query.preload([:unions, :tags]))

