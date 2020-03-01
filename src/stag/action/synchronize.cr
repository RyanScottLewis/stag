class Stag::Action::Synchronize < Stag::Action::Base

  def call
    Operation::Synchronize.call(@cli.options[:global])
  end

end

