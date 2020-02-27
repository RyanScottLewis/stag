module Stag

  VERSION = "0.0.1"

  alias Arguments = Array(String)

  alias Query = Crecto::Repo::Query

  alias FilesystemDirectory = NamedTuple(path: String)
  alias FilesystemSymlink   = NamedTuple(path: String, target: String)
  alias FilesystemEntry     = FilesystemDirectory | FilesystemSymlink
  alias FilesystemDelta     = NamedTuple(creation: Array(FilesystemEntry), deletion: Array(FilesystemEntry))

  # TODO: GlobalOptions instead of Options class?
  # TODO: REMOVE REOMVE
  #alias IndexOptions        = NamedTuple(columns: Array(String)?)
  #alias CreateOptions       = NamedTuple(name: String?, tags: String?)
  #alias UpdateSourceOptions = NamedTuple(name: String?, path: String?, tags: String?)
  #alias UpdateTagOptions    = NamedTuple(name: String?, path: String?)
  #alias CommandOptions      = CreateOptions | UpdateSourceOptions | UpdateTagOptions

  alias Route = NamedTuple(action: Symbol, to: Action::Base.class, aliases: Array(String), default: Bool)

end

