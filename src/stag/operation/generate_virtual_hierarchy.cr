# Generate VFS from a source.
class Stag::Operation::GenerateVirtualHierarchy < Stag::Operation::Base

  @source : Model::Source
  @tags   : Array(String)

  def initialize(@source, @tags)
  end

  def call
    virtual_hierarchy = [] of String

    if @tags.empty?
      virtual_hierarchy << File.join("/", @source.name!)
    else
      virtual_hierarchy += @tags.map do |tag_path|
        File.join("/", tag_path, @source.name!)
      end
    end

    virtual_hierarchy
  end

end

