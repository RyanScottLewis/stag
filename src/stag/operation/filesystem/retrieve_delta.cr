class Stag::Operation::Filesystem::RetrieveDelta < Stag::Operation::Base

  @options             : Options
  @filesystem_manifest : Array(FilesystemEntry)
  @virtual_manifest    : Array(FilesystemEntry)

  def initialize(@options, @filesystem_manifest, @virtual_manifest)
  end

  def call
    {
      deletion: @filesystem_manifest - @virtual_manifest,
      addition: @virtual_manifest    - @filesystem_manifest
    }
  end

end

