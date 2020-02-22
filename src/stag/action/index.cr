class Stag::Action::Index < Stag::Action::Base

  def call
    puts self.class
    virtual_manifest = Operation::Generate::VirtualManifest.call(@options)

    pp virtual_manifest
  end

end

