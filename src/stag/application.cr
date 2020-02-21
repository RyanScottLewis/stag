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
    delta               = Operation::Filesystem::RetrieveDelta.call(filesystem_manifest, virtual_manifest)

    pp delta
    #delta               = Operation::Filesystem::GenerateCommandOperations
  end

end

