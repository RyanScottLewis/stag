class Stag::Operation::Command::CreateDirectory < Stag::Operation::Command::Base

  @entry : FilesystemDirectory

  def initialize(@options, @entry)
  end

  def command
    "mkdir -p '%s'" % @entry.path
  end

  def report
    "\e[36m+ DIR:\e[0m %s" % @entry.path
  end

end

