abstract class Stag::Formatter::Base

  def self.call(data, *arguments)
    new(data, *arguments).call
  end

  macro inherited
    Formatter.register({{@type.stringify}}, {{@type}})
  end

  @data : Formatter::Data

  def initialize(@data)
  end

  abstract def call

end

