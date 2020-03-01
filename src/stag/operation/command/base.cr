abstract class Stag::Operation::Command::Base < Stag::Operation::Base

  abstract def command
  abstract def report

  @options : Options::Global

  def initialize(@options)
  end

  def call
    puts report

    message = ["  CMD".colorize(:yellow), command.colorize(:dark_gray)].join(" ")
    message += " [DRY]".colorize(:yellow).to_s if @options.dry

    puts message
    system command unless @options.dry
  end

end

