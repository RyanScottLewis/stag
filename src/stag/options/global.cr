# Application options.
class Stag::Options::Global < Stag::Options::Base

  property help     = false
  property verbose  = Verbose::QUIET
  property dry      = false
  property root     = "#{ENV["HOME"]}/.local/share/stag/fs"
  property database = "#{ENV["HOME"]}/.local/share/stag/database.db"
  property format   : String = "table" # TODO: Use this? Formatter.all.keys.first.not_nil!

end

