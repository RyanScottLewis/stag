class Stag::Formatter::JSON < Stag::Formatter::Base

  def initialize(@data, @pretty = true)
  end

  def call
    headers = @data[0]
    indent  = @pretty ? "  " : nil

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

