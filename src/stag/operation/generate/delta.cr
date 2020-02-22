# Generate the differences between the virtual filesystem and actual filesystem.
class Stag::Operation::Generate::Delta < Stag::Operation::Base

  @filesystem_manifest : Array(FilesystemEntry)
  @virtual_manifest    : Array(FilesystemEntry)

  def initialize(@filesystem_manifest, @virtual_manifest)
  end

  def call
    {
      deletion: @filesystem_manifest - @virtual_manifest,
      creation: @virtual_manifest    - @filesystem_manifest
    }
  end

end

