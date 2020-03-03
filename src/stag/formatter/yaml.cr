class Stag::Formatter::YAML < Stag::Formatter::Base

  # TODO: Completely unneeded but needs to be here due to Formatter::Base's inherited hook
  class Params < Formatter::Params
  end

  # TODO: Samesies
  def initialize(@data, @params = Params.new)
  end

  def call
    headers = @data[0]

    ::YAML.build do |builder|
      builder.sequence do
        @data[1..-1].each do |row|
          builder.mapping do
            headers.each_with_index do |header, index|
              builder.scalar header
              builder.scalar row[index]
            end
          end
        end
      end
    end
  end

end

