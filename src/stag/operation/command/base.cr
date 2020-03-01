abstract class Stag::Operation::Command::Base < Stag::Operation::Base

  abstract def command
  abstract def report

  @options : Options::Global

  def initialize(@options)
  end

  def call
    puts report if @options.verbose >= Verbose::STANDARD

    if @options.verbose >= Verbose::EXTRA
      puts [
        "CMD".ljust(4).colorize(:yellow),
        command.colorize(:dark_gray)
      ].join(" ")
    end

    system command unless @options.dry
  end

end

