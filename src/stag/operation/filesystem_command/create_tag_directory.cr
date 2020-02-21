class Stag::Operation::FilesystemCommand::CreateTagDirectory < Stag::Operation::Filesystem::Base

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

