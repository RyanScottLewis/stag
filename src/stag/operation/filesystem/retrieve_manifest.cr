class Stag::Operation::Filesystem::RetrieveManifest < Stag::Operation::Base

  @options : Options

  def initialize(@options)
  end

  def call
    retrieve_directories_and_symlinks(@options.root)
  end

  protected def retrieve_directories_and_symlinks(path, memo=[] of String)
    # ~50ms faster than Dir.each_child
    children = Dir.children(path)

    children.each do |child|
      # ~250ms faster than File.join since it iterates all arguments
      # ~20ms faster than Array#join
      # Seems about as fast as string interpolation with "#{}" instead of #+
      child_path = path + File::SEPARATOR + child

      # ~200ms faster than File.directory? and File.symlink? - I suspect they call File.info on each call
      info = File.info(child_path, false) # False is not to follow symlinks

      memo << child_path                                  if info.directory? || info.symlink?
      retrieve_directories_and_symlinks(child_path, memo) if info.directory?
    end

    memo
  end

end

