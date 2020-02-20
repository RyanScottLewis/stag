class Stag::Application

  include Concern::ClassCallable

  @arguments : Arguments

  def initialize(@arguments)
    @option_parser = OptionParser.new
    @options       = Options.new
  end

  def call
    Operation::ParseOptions.call(@arguments, @options, @option_parser)
    Operation::ProcessOptions.call(@options)
    Operation::SetupDatabase.call(@options)

    #pp @options
    #pp @arguments

    #target.tags.each do |tag|
      #Operation::Filesystem::CreateDirectory.call(@options, tag)
    #end
    #Operation::Filesystem::CreateTarget.call(@options, target, "/foo/bar/Old", "/bar/baz/New")
  end

end

