class Stag::Operation::Command::DeleteEntry < Stag::Operation::Command::Base

  @entry : FilesystemEntry

  def initialize(@options, @entry)
  end

  def command
    "rm -r '%s'" % @entry.path
  end

  def report
    name = @entry.is_a?(FilesystemDirectory) ? "DIR" : "LINK"

    "\e[35m- %s:\e[0m %s\e[95m" % [name, @entry.path]
  end

end

