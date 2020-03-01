# Index action options.
class Stag::Options::Index < Stag::Options::Base

  COLUMNS = ["id", "name", "path", "tags", "vfs"]

  property columns : Array(String) = COLUMNS.clone

end

