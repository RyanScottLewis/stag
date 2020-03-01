# Create a symlink based on a FilesystemSymlink.
class Stag::Operation::Command::CreateSymlink < Stag::Operation::Command::Base

  @entry : FilesystemSymlink

  def initialize(@options, @entry)
  end

  def command
    "ln -s '%s' '%s'" % [@entry[:target], @entry[:path]]
  end

  def report
    dry = @options.dry ? "[DRY]".colorize(:yellow).to_s : nil

    [
      "LINK".ljust(4).colorize(:light_magenta),
      "+".colorize(:green),
      dry,
      @entry[:path],
      "→".colorize(:light_magenta),
      @entry[:target],
    ].compact.join(" ")
  end

end

