# The application.
class Stag::Application

  include Concern::ClassCallable

  @arguments : Arguments

  def initialize(@arguments)
    @options = Options::Global.new
  end

  getter arguments
  getter options

  def call
    Interface::CLI.call(self)

    #data = [
      #["Header A", "Header B"],
      #["Item A",   "Item B"],
      #["Thing A",  "Thing B"],
      #["Stuff A",  "Stuff B"],
    #]

    #print "-=" * 60
    #puts "\r-= Crystal "
    #pp data
    #print "-=" * 60
    #puts "\r-= Text table bordered "
    #puts Formatter::TextTable.call(data)
    #print "-=" * 60
    #puts "\r-= Text table borderless "
    #puts Formatter::TextTable.call(data, false)
    #print "-=" * 60
    #puts "\r-= CSV "
    #puts Formatter::CSV.call(data)
    #print "-=" * 60
    #puts "\r-= CSV (space separator) "
    #puts Formatter::CSV.call(data, ' ')
    #print "-=" * 60
    #puts "\r-= CSV (tab separator) "
    #puts Formatter::CSV.call(data, '\t')
    #print "-=" * 60
    #puts "\r-= YAML "
    #puts Formatter::YAML.call(data)
    #print "-=" * 60
    #puts "\r-= JSON (pretty) "
    #puts Formatter::JSON.call(data)
    #print "-=" * 60
    #puts "\r-= JSON (compact) "
    #puts Formatter::JSON.call(data, false)
  end


end

