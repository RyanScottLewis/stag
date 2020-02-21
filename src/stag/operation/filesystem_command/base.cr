abstract class Stag::Operation::FilesystemCommand::Base < Stag::Operation::Base

  abstract def command
  abstract def report

  @options : Options

  def initialize(@options)
  end

  def call
    puts report

    message = "      \e[90m%s\e[0m" % command
    message += " \e[33m[DRY]\e[90m" if @options.dry

    puts message
    system command unless @options.dry
  end

end

