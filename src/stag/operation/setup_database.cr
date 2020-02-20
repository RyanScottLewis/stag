class Stag::Operation::SetupDatabase < Stag::Operation::Base

  @options : Options

  def initialize(@options)
  end

  def call
    setup_database_path

    open_database do |db|
      create_sources_table(db)
      create_tags_table(db)
      create_unions_table(db)
    end
  end

  protected def setup_database_path
    dirname = File.dirname(@options.database)
    Dir.mkdir_p(dirname)

    Repository.config.database = @options.database
  end

  protected def open_database
    DB.open(Repository.config.database_url) do |db|
      yield db
    end
  end

  protected def create_sources_table(db)
    db.exec <<-SQL
      CREATE TABLE IF NOT EXISTS sources (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        path TEXT NOT NULL
      );
    SQL
  end

  protected def create_tags_table(db)
    db.exec <<-SQL
      CREATE TABLE IF NOT EXISTS tags (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        path TEXT NOT NULL,
        level INTEGER NOT NULL,
        parent_id INTEGER
      );
    SQL
  end

  protected def create_unions_table(db)
    db.exec <<-SQL
      CREATE TABLE IF NOT EXISTS unions (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        source_id INTEGER NOT NULL,
        tag_id INTEGER NOT NULL
      );
    SQL
  end

end

