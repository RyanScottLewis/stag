class Stag::Interface::CLI < Stag::Interface::Base

  @arguments : Arguments
  @options : NamedTuple(global: Options::Global, index: Options::Index)

  def initialize(application)
    @arguments = application.arguments
    @router    = Router.new

    @options = {
      global: application.options,
      index:  Options::Index.new,
    }

    @option_parsers = {
      global: ::OptionParser.new,
      index:  ::OptionParser.new,
    }
  end

  getter arguments
  getter options
  getter option_parsers
  getter router

  def call
    # TODO: Operation::LoadOptions.call(@options)
    OptionParser::Global.call(self)
    Operation::SetupDatabase.call(@options[:global])
    #Operation::RouteAction.call(self)

    #Operation::Synchronize.call(@options) # TODO: Only if needed
  end

end

