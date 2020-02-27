# Generate command operations based on the difference in filesystem and virtual filesystem
# differences (delta.)
class Stag::Operation::Generate::Commands < Stag::Operation::Base

  @options : Options::Global
  @delta   : FilesystemDelta

  def initialize(@options, @delta)
  end

  def call
    generate_commands
  end

  protected def generate_commands
    [
      generate_deletion_commands,
      generate_creation_commands
    ].flatten.compact
  end

  protected def generate_deletion_commands
    @delta[:deletion].map do |entry|
      Command::DeleteEntry.new(@options, entry)
    end
  end

  protected def generate_creation_commands
    @delta[:creation].map do |entry|
      if entry.is_a?(FilesystemDirectory)
        Command::CreateDirectory.new(@options, entry)
      elsif entry.is_a?(FilesystemSymlink)
        Command::CreateSymlink.new(@options, entry)
      end
    end
  end

end

