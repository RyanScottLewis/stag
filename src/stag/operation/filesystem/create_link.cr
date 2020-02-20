class Stag::Operation::Filesystem::CreateLink < Stag::Operation::Filesystem::Base

  @link        : Model::Link
  @source      : String
  @destination : String

  def initialize(@options, @link, @source, @destination)
  end

  command { "ln -s '%s' '%s'" % [@source, @destination] }

  report { "\e[35mLINK:\e[0m %s \e[95m→\e[0m \e[35m%s\e[0m" % [@source, @destination] }

end

