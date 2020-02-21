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
    filesystem_manifest = Operation::Filesystem::GenerateFilesystemManifest.call(@options)
    virtual_manifest    = Operation::Filesystem::GenerateVirtualManifest.call(@options)

    puts
    pp filesystem_manifest
    puts
    pp virtual_manifest
    puts
    #Operation::RetrieveFilesystemDelta.call(@options, @manifest)
    #Operation::SynchronizeFilesystem.call(@options, @delta)

    #Operation::Filesystem::Synchronize.call(@options)
  end

end

