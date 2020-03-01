# Delete a filesystem entry based on a FilesystemEntry.
class Stag::Operation::Command::DeleteEntry < Stag::Operation::Command::Base

  @entry : FilesystemEntry

  def initialize(@options, @entry)
  end

  def command
    "rm -r '%s'" % @entry[:path]
  end

  def report
    name = @entry.is_a?(FilesystemDirectory) ? "DIR".ljust(4).colorize(:light_blue) : "LINK".ljust(4).colorize(:light_magenta)

    [
      name,
      "-".colorize(:red),
      @entry[:path]
    ].join(" ")
  end

end

