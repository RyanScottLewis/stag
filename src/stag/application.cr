# The application.
class Stag::Application

  include Concern::ClassCallable

  @arguments : Arguments

  def initialize(@arguments)
    @option_parser = OptionParser.new
    @options       = Options::Global.new
    @router        = Router.new
  end

  def call
    Crecto::DbLogger.set_handler(STDOUT) # TODO: DEBUG option?

    Operation::ParseOptions.call(@arguments, @options, @option_parser)
    Operation::ProcessOptions.call(@options) # TODO: Is this genuinely needed? Move functionality over to ParseOptions
    Operation::SetupDatabase.call(@options)

    Operation::RouteAction.call(@arguments, @options, @router)

    #Operation::Synchronize.call(@options) # TODO: Only if needed
  end

end

