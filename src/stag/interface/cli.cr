class Stag::Interface::CLI < Stag::Interface::Base

  @arguments : Arguments
  @options : NamedTuple(global: Options::Global, index: Options::Index)

  def initialize(application)
    @arguments = application.arguments

    @router = Router.new do |router|
      router.map(%w[help],                  action: Action::Help)
      router.map(%w[index list],            action: Action::Index, default: true)
      router.map(%w[create new],            action: Action::Create)
      router.map(%w[read show view],        action: Action::Read)
      router.map(%w[update edit],           action: Action::Update)
      router.map(%w[destroy delete remove], action: Action::Destroy)
    end

    @options = {
      global: application.options,
      index:  Options::Index.new,
    }

    @option_parsers = {
      global: OptionParser::Global.new(@arguments, @options[:global]),
      index:  OptionParser::Index.new(@arguments, @options[:index]),
    }
  end

  getter arguments
  getter options
  getter option_parsers
  getter router

  def call
    # TODO: Operation::LoadOptions.call(@options)

    #OptionParser::Global.call(self)
    @option_parsers[:global].call

    Operation::SetupDatabase.call(@options[:global])
    Operation::RouteAction.call(self)

    #Operation::Synchronize.call(@options) # TODO: Only if needed
  end

end

