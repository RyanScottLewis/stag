class Stag::Operation::Filesystem::CreateSourceSymlink < Stag::Operation::Filesystem::Base

  @source      : Model::Source
  @destination : String

  def initialize(@options, @source, @destination)
  end

  command { "ln -s '%s' '%s'" % [@source.path, @destination] }

  report { "\e[35mLINK:\e[0m %s \e[95m→\e[0m \e[35m%s\e[0m" % [@source.path, @destination] }

end

