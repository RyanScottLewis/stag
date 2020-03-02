# Application options.
class Stag::Options::Global < Stag::Options::Base

  property help     = false
  property verbose  = Verbose::QUIET
  property dry      = false
  property root     = "#{ENV["HOME"]}/.local/share/stag/fs"
  property database = "#{ENV["HOME"]}/.local/share/stag/database.db"
  property format   : String = Operation::FormatData::FORMATTERS.keys.first.not_nil! # TODO: Formatter.all...

end

