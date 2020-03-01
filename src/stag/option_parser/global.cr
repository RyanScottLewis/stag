# Global options parser.
class Stag::OptionParser::Global < Stag::OptionParser::Base

  banner do
    <<-STR
    Usage: stag [ACTION] [OPTIONS]

    File#{"s".colorize.bold}ystem #{"tag".colorize.bold}s.
    Hierarchically tag filesystem entries and generate/synchronize a filesystem hierarchy of directories and symlinks based on the tagged entries.

    Actions:
        help [ACTION]                    Display help
        index,   list                    List all tags/sources (default command)
        create,  new                     Create a tag/source
        read,    show,   view            Show a tag/source
        update,  edit                    Edit a tag/source
        destroy, delete, remove          Remove a tag/source
        sync,    synchronize             Synchronize with the filesystem

    Options:
    STR
  end

  options do
    bool :help,     :h, "Display help"
    bool :verbose,  :v, "Run verbosely"
    bool :dry,      :D, "Run without making changes"
    path :root,     :r, "Root path for generating tag filesystem"
    path :database, :d, "Path to the SQLite database"
  end

end

