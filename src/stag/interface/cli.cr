class Stag::Interface::CLI < Stag::Interface::Base

  @arguments : Arguments
  @options   : Options

  def initialize(application)
    @arguments = application.arguments

    @router = Router.new do |router|
      router.map(%w[help],                  action: Action::Help)
      router.map(%w[index list],            action: Action::Index, default: true)
      router.map(%w[create new],            action: Action::Create)
      router.map(%w[read show view],        action: Action::Read)
      router.map(%w[update edit],           action: Action::Update)
      router.map(%w[destroy delete remove], action: Action::Destroy)
      router.map(%w[sync synchronize],      action: Action::Synchronize)
    end

    @options = application.options

    @option_parsers = {
      global:      OptionParser::Global.new(@arguments, @options),
      index:       OptionParser::Index.new(@arguments, @options),
      read:        OptionParser::Read.new(@arguments, @options),
      synchronize: OptionParser::Synchronize.new(@arguments, @options),
    }

    Crecto::DbLogger.set_handler(STDOUT)
    Crecto::DbLogger.options = @options

    Colorize.on_tty_only!

  end

  getter arguments
  getter options
  getter option_parsers
  getter router

  def call
    # TODO: Operation::LoadOptions.call(@options)

    @option_parsers[:global].call

    if @options.help
      Action::Help.call(self)
    else
      Operation::SetupDatabase.call(@options)
      Operation::RouteAction.call(self)
    end


    #Operation::Synchronize.call(@options) # TODO: Only if needed
  end

end

