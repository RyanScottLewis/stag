class Stag::Interface::CLI < Stag::Interface::Base

  @arguments : Arguments
  @options : NamedTuple(global: Options::Global, index: Options::Index, synchronize: Options::Synchronize)

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

    @options = {
      global:      application.options,
      index:       Options::Index.new,
      synchronize: Options::Synchronize.new,
    }

    @option_parsers = {
      global:      OptionParser::Global.new(@arguments, @options[:global]),
      index:       OptionParser::Index.new(@arguments, @options[:index]),
      synchronize: OptionParser::Synchronize.new(@arguments, @options[:synchronize]),
    }
  end

  getter arguments
  getter options
  getter option_parsers
  getter router

  def call
    # TODO: Operation::LoadOptions.call(@options)

    @option_parsers[:global].call

    if @options[:global].help
      Action::Help.call(self)
    else
      Operation::SetupDatabase.call(@options[:global])
      Operation::RouteAction.call(self)
    end


    #Operation::Synchronize.call(@options) # TODO: Only if needed
  end

end

