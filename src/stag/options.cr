# Application options.
class Stag::Options

  COLUMNS = ["id", "name", "path", "tags", "vfs"]

  property help     = false
  property verbose  = Verbose::QUIET
  property dry      = false
  property root     = "#{ENV["HOME"]}/.local/share/stag/fs"
  property database = "#{ENV["HOME"]}/.local/share/stag/database.db"
  property format   : String = "table" # TODO: Use this? Formatter.all.keys.first.not_nil!
  property columns  : Array(String) = COLUMNS.clone

  property table_borders = false
  property csv_separator = ','
  property json_pretty   = false

end

