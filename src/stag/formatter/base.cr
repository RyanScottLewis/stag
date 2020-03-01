abstract class Stag::Formatter::Base

  def self.call(data, *arguments)
    new(data, *arguments).call
  end

  @data : Array(Array(String))

  def initialize(@data)
  end

  abstract def call

end

