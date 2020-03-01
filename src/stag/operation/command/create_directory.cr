# Create a directory based on a FilesystemDirectory.
class Stag::Operation::Command::CreateDirectory < Stag::Operation::Command::Base

  @entry : FilesystemDirectory

  def initialize(@options, @entry)
  end

  def command
    "mkdir -p '%s'" % @entry[:path]
  end

  def report
    dry = @options.dry ? "[DRY]".colorize(:yellow).to_s : nil

    [
      "DIR".ljust(4).colorize(:light_blue),
      "+".colorize(:green),
      dry,
      @entry[:path],
    ].compact.join(" ")
  end

end

