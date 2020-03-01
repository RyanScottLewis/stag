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
    {% unless flag?(:release) %}
      Crecto::DbLogger.set_handler(STDOUT)
    {% end %}

    Colorize.on_tty_only!

    Interface::CLI.call(self)
  end

end

