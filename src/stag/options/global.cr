# Application options.
class Stag::Options::Global < Stag::Options::Base

  property help     = false
  property verbose  = false
  property dry      = false
  property root     = "~/.local/share/stag/fs"
  property database = "~/.local/share/stag/database.db"

end

