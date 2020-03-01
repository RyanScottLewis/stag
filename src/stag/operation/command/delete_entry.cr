# Delete a filesystem entry based on a FilesystemEntry.
class Stag::Operation::Command::DeleteEntry < Stag::Operation::Command::Base

  @entry : FilesystemEntry

  def initialize(@options, @entry)
  end

  def command
    "rm -r '%s'" % @entry[:path]
  end

  def report
    name = @entry.is_a?(FilesystemDirectory) ? "DIR ".colorize(:light_blue) : "LINK".colorize(:light_magenta)

    [
      "-".colorize(:red),
      name,
      @entry[:path]
    ].join(" ")
  end

end

