class Stag::Formatter::YAML < Stag::Formatter::Base

  def call
    ::YAML.build do |builder|
      builder.sequence do
        @sources.each do |source|
          tags              = Operation::GenerateTags.call(source)
          virtual_hierarchy = Operation::GenerateVirtualHierarchy.call(source, tags)

          builder.mapping do

            builder.scalar "id"
            builder.scalar source.id

            builder.scalar "name"
            builder.scalar source.name!

            builder.scalar "path"
            builder.scalar source.path!

            builder.scalar "tags"
            builder.sequence do
              tags.each do |tag|
                builder.scalar tag
              end
            end

            builder.scalar "vfs"
            builder.sequence do
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

