class Stag::Operation::Filesystem::Command::CreateTagDirectory < Stag::Operation::Filesystem::Command::Base

  @tag         : Model::Tag
  @destination : String

  def initialize(@options, @tag)
    @destination = File.join(@options.root, @tag.path!)
  end

  def command
    "mkdir -p '%s'" % @destination
  end

  def report
    "\e[36mDIR:\e[0m  %s" % @destination
  end

end

