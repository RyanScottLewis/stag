class Stag::Operation::Command::CreateSymlink < Stag::Operation::Command::Base

  @entry : FilesystemSymlink

  def initialize(@options, @entry)
  end

  def command
    "ln -s '%s' '%s'" % [@entry[:target], @entry[:path]]
  end

  def report
    "\e[35m+ LINK:\e[0m %s \e[95m→\e[0m \e[35m%s\e[0m" % [@entry[:path], @entry[:target]]
  end

end

