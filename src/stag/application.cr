# The application.
class Stag::Application

  include Concern::ClassCallable

  @arguments : Arguments

  def initialize(@arguments)
    @options = Options::Global.new
    @router  = Router.new
  end

  def call
    Crecto::DbLogger.set_handler(STDOUT) # TODO: DEBUG option?

    Operation::ParseOptions::Global.call(@arguments, @options)
    Operation::SetupDatabase.call(@options)
    Operation::RouteAction.call(@arguments, @options, @router)

    #Operation::Synchronize.call(@options) # TODO: Only if needed
  end

end

