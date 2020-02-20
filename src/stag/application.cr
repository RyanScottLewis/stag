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

    link = Repository.get!(Model::Link, 1, Query.preload([:unions, :tags]))


    Operation::Filesystem::CreateLink.call(@options, link, "/foo/bar/Old", "/bar/baz/New")
  end

end

