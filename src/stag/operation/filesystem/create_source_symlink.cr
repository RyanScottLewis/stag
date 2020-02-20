class Stag::Operation::Filesystem::CreateSourceSymlink < Stag::Operation::Filesystem::Base

  @source      : Model::Source
  @tag         : Model::Tag
  @destination : String

  def initialize(@options, @source, @tag)
    @destination = File.join(@options.root, @tag.path!, @source.name!)
  end

  def command
    "ln -s '%s' '%s'" % [@source.path, @destination]
  end

  def report
    "\e[35mLINK:\e[0m %s \e[95m→\e[0m \e[35m%s\e[0m" % [@source.path, @destination]
  end

end

