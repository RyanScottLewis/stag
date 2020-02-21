class Stag::Application

  include Concern::ClassCallable

  @arguments : Arguments

  def initialize(@arguments)
    @option_parser = OptionParser.new
    @options       = Options.new
  end

  def call
    # TODO: DEBUG
    #Crecto::DbLogger.set_handler(STDOUT)

    Operation::ParseOptions.call(@arguments, @options, @option_parser)
    Operation::ProcessOptions.call(@options)
    Operation::SetupDatabase.call(@options)

    # TODO:
    manifest = Operation::Filesystem::GenerateFilesystemManifest.call(@options)

    puts
    pp manifest
    puts
    #Operation::RetrieveFilesystemDelta.call(@options, @manifest)
    #Operation::SynchronizeFilesystem.call(@options, @delta)

    #Operation::Filesystem::Synchronize.call(@options)
  end

end

