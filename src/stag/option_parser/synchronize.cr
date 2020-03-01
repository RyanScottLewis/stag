class Stag::OptionParser::Synchronize < Stag::OptionParser::Base

  banner do
    <<-STR
    Usage: stag synchronize [OPTIONS]
           stag sync [OPTIONS]

    Synchronize the virtual filesystem consisting of hierarchical tags and sources with the filesystem using tag directories and source symlinks.

    Options:
    STR
  end

  #options do
    #bool "nondestructive", :c, "--non-destructive"
  #end

end

