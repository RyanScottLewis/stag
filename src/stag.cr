module Stag

  VERSION = "0.0.1"

  alias Arguments       = Array(String)

  alias Query           = Crecto::Repo::Query

  alias FilesystemEntry = NamedTuple(type: File::Type, path: String)
  alias FilesystemDelta = NamedTuple(creation: Array(FilesystemEntry), deletion: Array(FilesystemEntry))

end

