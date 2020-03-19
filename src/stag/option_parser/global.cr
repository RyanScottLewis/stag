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

    Global Options:
    STR
  end

  options do
    bool   :help,          :h, "Display help"
    value( :verbose,       :v, "Run verbosely (0-3)") { Verbose.new(value.to_i) }
    bool   :dry,           :D, "Run without making changes"
    path   :root,          :r, "Root path for generating tag filesystem"
    path   :database,      :d, "Path to the SQLite database"
    string :format,        :f, "Output format (#{Formatter.all.keys.sort.join(",")})"
    bool   :table_borders,     "Table borders"
    char   :csv_separator,     "CSV separation character"
    bool   :json_pretty,       "JSON pretty output"
  end

  protected def setup_missing_option_handler
    @parser.missing_option do |option|
      case option
      when "-v", "--verbose" then @options.verbose = Verbose::STANDARD
      else
        raise ::OptionParser::MissingOption.new(option)
      end
    end
  end

end

