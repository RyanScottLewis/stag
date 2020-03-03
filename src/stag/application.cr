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
  end


end

