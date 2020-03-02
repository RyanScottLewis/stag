class Stag::Formatter::JSON < Stag::Formatter::Base

  class Params < Formatter::Params

    property pretty

    def initialize(@pretty = true)
    end

  end

  def initialize(@data, @params = Params.new)
  end

  def call
    headers = @data[0]
    indent  = @params.pretty ? "  " : nil

    ::JSON.build(indent) do |builder|
      builder.array do
        @data[1..-1].each do |row|
          builder.object do
            headers.each_with_index do |header, index|
              builder.field header, row[index]
            end
          end
        end
      end
    end
  end

end

