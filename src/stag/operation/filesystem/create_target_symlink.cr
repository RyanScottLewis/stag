class Stag::Operation::Filesystem::CreateTargetSymlink < Stag::Operation::Filesystem::Base

  @target      : Model::Target
  @source      : String
  @destination : String

  def initialize(@options, @target, @source, @destination)
  end

  command { "ln -s '%s' '%s'" % [@source, @destination] }

  report { "\e[35mLINK:\e[0m %s \e[95m→\e[0m \e[35m%s\e[0m" % [@source, @destination] }

end

