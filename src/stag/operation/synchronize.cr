# Synchronize the data from the database to the data on the filesystem.
#
# * Tags are hierarchical, so they are directories and Targets are symlinks.
# * Generate the difference (delta) between the virtual filesystem, generated from Tags and Targets
#   in the database, and the actual filesystem, from application option's `root`.
# * Generate system commands to create/delete filesystem entries based on virtual filesystem entries.
# * Run all commands.
class Stag::Operation::Synchronize < Stag::Operation::Base

  @options : Options

  def initialize(@options)
  end

  def call
    filesystem_manifest = Filesystem::GenerateFilesystemManifest.call(@options)
    virtual_manifest    = Filesystem::GenerateVirtualManifest.call(@options)
    delta               = Filesystem::GenerateDelta.call(filesystem_manifest, virtual_manifest)
    commands            = Filesystem::GenerateCommandOperations.call(@options, delta)

    commands.each(&.call)
  end

end

