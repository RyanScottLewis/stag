# Database repository and adapter.
module Stag::Repository

  extend Crecto::Repo

  config do |conf|
    conf.adapter  = Crecto::Adapters::SQLite3
    conf.database = "./tmp/database.db"
  end

end

