class Stag::OptionParser::Read < Stag::OptionParser::Base

  banner do
    <<-STR
    Usage: stag read PATH [OPTIONS]
           stag show PATH [OPTIONS]
           stag view PATH [OPTIONS]

    Synchronize the virtual filesystem consisting of hierarchical tags and sources with the filesystem using tag directories and source symlinks.

    Arguments:
        PATH                             Real or virtual tag/source path
    STR
  end

end

