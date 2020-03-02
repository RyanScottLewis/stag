abstract class Stag::Formatter::Base

  def self.call(data, *arguments)
    new(data, *arguments).call
  end

  @data : Formatter::Data

  def initialize(@data)
  end

  abstract def call

end

