class Stag::Formatter::JSON < Stag::Formatter::Base

  def call
    indent = @options.json_pretty ? "  " : nil

    ::JSON.build(indent) do |builder|
      builder.array do
        @sources.each do |source|
          tags              = Operation::GenerateTags.call(source)
          virtual_hierarchy = Operation::GenerateVirtualHierarchy.call(source, tags)

          builder.object do

            builder.scalar "id"
            builder.scalar source.id

            builder.scalar "name"
            builder.scalar source.name!

            builder.scalar "path"
            builder.scalar source.path!

            builder.scalar "tags"
            builder.array do
              tags.each do |tag|
                builder.scalar tag
              end
            end

            builder.scalar "vfs"
            builder.array do
              virtual_hierarchy.each do |path|
                builder.scalar path
              end
            end

          end
        end
      end
    end
  end

end

