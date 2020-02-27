abstract class Stag::Action::Base

  include Concern::ClassCallable

  @cli : Interface::CLI

  def initialize(@cli)
  end

  def call; end

end

