abstract class Stag::Action::Base

  include Concern::ClassCallable

  @options : Options

  def initialize(@options)
  end

  def call; end

end

