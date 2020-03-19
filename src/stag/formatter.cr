module Stag::Formatter

  class_getter all = {} of String => Formatter::Base.class

  def self.register(name : String, formatter_class : Formatter::Base.class)
    @@all[name] = formatter_class
  end

  def self.[](name : String)
    @@all[name]
  end

  def self.[]?(name : String)
    @@all[name]?
  end

  alias Data = Array(Model::Source)

end

