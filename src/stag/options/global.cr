# Application options.
class Stag::Options::Global < Stag::Options::Base

  property help     = false
  property verbose  = false
  property dry      = false
  property root     = "#{ENV["HOME"]}/.local/share/stag/fs"
  property database = "#{ENV["HOME"]}/.local/share/stag/database.db"

end

