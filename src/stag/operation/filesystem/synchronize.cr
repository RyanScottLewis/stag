class Stag::Operation::Filesystem::Synchronize < Stag::Operation::Base

  @options : Options

  def initialize(@options)
  end

  def call
    filesystem_manifest = Operation::Filesystem::GenerateFilesystemManifest.call(@options)
    virtual_manifest    = Operation::Filesystem::GenerateVirtualManifest.call(@options)
    delta               = Operation::Filesystem::GenerateDelta.call(filesystem_manifest, virtual_manifest)
    commands            = Operation::Filesystem::GenerateCommandOperations.call(@options, delta)

    commands.each(&.call)
  end

end

