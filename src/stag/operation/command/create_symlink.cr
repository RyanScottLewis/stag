# Create a symlink based on a FilesystemSymlink.
class Stag::Operation::Command::CreateSymlink < Stag::Operation::Command::Base

  @entry : FilesystemSymlink

  def initialize(@options, @entry)
  end

  def command
    "ln -s '%s' '%s'" % [@entry[:target], @entry[:path]]
  end

  def report
    [
      "+".colorize(:green),
      "LINK".colorize(:light_magenta),
      @entry[:path],
      "→".colorize(:light_magenta),
      @entry[:target]
    ].join(" ")
  end

end

