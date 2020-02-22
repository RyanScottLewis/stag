class Stag::Operation::Filesystem::Synchronize < Stag::Operation::Base

  @options : Options

  def initialize(@options)
  end

  def call
    filesystem_manifest = GenerateFilesystemManifest.call(@options)
    virtual_manifest    = GenerateVirtualManifest.call(@options)
    delta               = GenerateDelta.call(filesystem_manifest, virtual_manifest)
    commands            = GenerateCommandOperations.call(@options, delta)

    commands.each(&.call)
  end

end

