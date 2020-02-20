class Stag::Operation::Filesystem::CreateTagDirectory < Stag::Operation::Filesystem::Base

  @tag         : Model::Tag
  @destination : String

  def initialize(@options, @tag)
    @destination = File.join(@options.root, @tag.path!)
  end

  command { "mkdir -p '%s'" % @destination }

  report { "\e[36mDIR:\e[0m  %s" % @destination }

end

