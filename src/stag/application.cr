class Stag::Application

  include Concern::ClassCallable

  @arguments : Arguments

  def initialize(@arguments)
    @option_parser = OptionParser.new
    @options       = Options.new
  end

  def call
    # TODO: DEBUG
    Crecto::DbLogger.set_handler(STDOUT)

    Operation::ParseOptions.call(@arguments, @options, @option_parser)
    Operation::ProcessOptions.call(@options)
    Operation::SetupDatabase.call(@options)

    #omg = Operation::GenerateFilesystemOperations.call

    #pp omg.first
    #pp omg.first.children.first
    #pp omg.first.children.first.parent

  end

end

