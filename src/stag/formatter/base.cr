abstract class Stag::Formatter::Base

  include Concern::ClassCallable

  macro inherited
    Formatter.register({{@type.stringify.split("::").last.underscore}}, {{@type}})
  end

  @data    : Formatter::Data
  @options : Options::Global

  def initialize(@data, @options)
  end

  abstract def call

end

