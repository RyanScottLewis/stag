# Create a directory based on a FilesystemDirectory.
class Stag::Operation::Command::CreateDirectory < Stag::Operation::Command::Base

  @entry : FilesystemDirectory

  def initialize(@options, @entry)
  end

  def command
    "mkdir -p '%s'" % @entry[:path]
  end

  def report
    [
      "+".colorize(:green),
      "DIR".colorize(:light_blue),
      @entry[:path]
    ].join(" ")
  end

end

