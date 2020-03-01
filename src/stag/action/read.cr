class Stag::Action::Read < Stag::Action::Base

  def call
    puts self.class

    pp @cli.arguments
  end

end

