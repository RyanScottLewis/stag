# Preprocess arguments - expanding paths and stripping strings.
class Stag::Operation::ProcessOptions < Stag::Operation::Base

  @options : Options

  def initialize(@options)
  end

  def call
    strip_strings
    expand_paths
  end

  protected def strip_strings
    @options.root     = @options.root.strip
    @options.database = @options.database.strip
  end

  protected def expand_paths
    @options.root     = expand(@options.root)
    @options.database = expand(@options.database)
  end

  protected def expand(path)
    File.expand_path(path, home: true)
  end

end

