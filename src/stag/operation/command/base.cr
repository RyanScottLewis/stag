abstract class Stag::Operation::Command::Base < Stag::Operation::Base

  abstract def command
  abstract def report

  @options : Options::Global

  def initialize(@options)
  end

  def call
    puts report

    message = "  \e[33mCMD\e[0m  \e[90m%s\e[0m" % command
    message += " \e[33m[DRY]\e[90m" if @options.dry

    puts message
    system command unless @options.dry
  end

end

