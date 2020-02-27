# Parses options from the application's arguments destructively.
class Stag::Operation::ParseOptions::Global < Stag::Operation::ParseOptions::Base

  @options : Options::Global

  def initialize(@arguments, @options)
    super(@arguments)
  end

  def call
    setup_banner
    setup_options
    super
  end

  protected def setup_banner
    # TODO: Magic string - Use like Stag::NAME or something
    @parser.banner = <<-BANNER
    Usage: stag [ACTION] [OPTIONS]

    File\e[4m\e[1ms\e[0mystem \e[4m\e[1mtag\e[0ms.
    Hierarchically tag filesystem entries and generate/synchronize a filesystem hierarchy of directories and symlinks based on the tagged entries.

    Commands:
        index,   list                    List all tags/sources (default command)
        create,  new                     Create a tag/source
        read,    show,   view            Show a tag/source
        update,  edit                    Edit a tag/source
        destroy, delete, remove          Remove a tag/source

    Options:
    BANNER
  end

  protected def setup_options
    @parser.on("-h", "--help",           "Show help")                               {         @options.help     = true }
    @parser.on("-v", "--verbose",        "Run verbosely")                           {         @options.verbose  = true }
    @parser.on("-D", "--dry",            "Run without making changes")              {         @options.dry      = true }
    @parser.on("-r", "--root VALUE",     "Root path for generating tag filesystem") { |value| @options.root     = expand_path(value) }
    @parser.on("-d", "--database VALUE", "Path to the SQLite databsae")             { |value| @options.database = expand_path(value) }
  end

end

