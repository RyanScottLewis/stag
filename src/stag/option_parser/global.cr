# Global options parser.
class Stag::OptionParser::Global < Stag::OptionParser::Base

  banner do
    <<-STR
    Usage: stag [ACTION] [OPTIONS]

    File\e[4m\e[1ms\e[0mystem \e[4m\e[1mtag\e[0ms.
    Hierarchically tag filesystem entries and generate/synchronize a filesystem hierarchy of directories and symlinks based on the tagged entries.

    Commands:
        help [ACTION]                    Display help
        index,   list                    List all tags/sources (default command)
        create,  new                     Create a tag/source
        read,    show,   view            Show a tag/source
        update,  edit                    Edit a tag/source
        destroy, delete, remove          Remove a tag/source

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

