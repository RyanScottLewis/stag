module Stag

  VERSION = "0.0.1"

  alias Arguments       = Array(String)
  alias FilesystemEntry = NamedTuple(type: File::Type, path: String)
  alias Query           = Crecto::Repo::Query

end

