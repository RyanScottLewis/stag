abstract class Stag::Action::Base

  include Concern::ClassCallable

  @arguments : Arguments
  @options   : Options

  def initialize(@arguments, @options)
  end

  def call; end

end

