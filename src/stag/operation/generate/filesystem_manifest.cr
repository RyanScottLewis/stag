# Generate FilesystemEntries based on the actual filesystem.
class Stag::Operation::Generate::FilesystemManifest < Stag::Operation::Base

  @options : Options::Global

  def initialize(@options)
  end

  def call
    retrieve_directories_and_symlinks(@options.root)
  end

  # Note: This is about as optimized as I can make this. Went from ~15x slower than `find` to ~3-4x slower
  protected def retrieve_directories_and_symlinks(path, memo=[] of FilesystemEntry)
    # ~50ms faster than Dir.each_child
    children = Dir.children(path)

    children.each do |child|
      # ~250ms faster than File.join since it iterates all arguments
      # ~20ms faster than Array#join
      # Seems about as fast as string interpolation with "#{}" instead of #+
      child_path = path + File::SEPARATOR + child

      # ~200ms faster than File.directory? and File.symlink? - I suspect they call File.info on each call
      info = File.info(child_path, false) # False is not to follow symlinks


      if info.directory?
        memo << { path: child_path }

        retrieve_directories_and_symlinks(child_path, memo)
      elsif info.symlink?
        memo << { path: child_path, target: File.readlink(child_path) }
      end
    end

    memo
  end

end

