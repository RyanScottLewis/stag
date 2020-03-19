abstract class Stag::Formatter::Base

  include Concern::ClassCallable

  macro inherited
    Formatter.register({{@type.stringify.split("::").last.underscore}}, {{@type}})
  end

  @sources : Array(Model::Source)
  @options : Options

  def initialize(@sources, @options)
  end

  abstract def call

end

