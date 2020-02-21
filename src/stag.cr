module Stag

  VERSION = "0.0.1"

  alias Arguments = Array(String)

  alias Query = Crecto::Repo::Query

  alias FilesystemDirectory = NamedTuple(path: String)
  alias FilesystemSymlink   = NamedTuple(path: String, target: String)
  alias FilesystemEntry     = FilesystemDirectory | FilesystemSymlink
  alias FilesystemDelta     = NamedTuple(creation: Array(FilesystemEntry), deletion: Array(FilesystemEntry))

end

