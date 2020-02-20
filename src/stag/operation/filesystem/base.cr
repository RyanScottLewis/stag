abstract class Stag::Operation::Filesystem::Base < Stag::Operation::Base

  macro def_block_method(*names)
    {% for name in names %}
      macro {{name}}(&block)
        def {{name}}
          \{{block.body}}
        end
      end
    {% end %}
  end

  def_block_method command
  def_block_method report

  @options : Options

  def initialize(@options)
  end

  def call
    puts report

    message = "      \e[90m%s\e[0m" % command
    message += " \e[33m[DRY]\e[90m" if @options.dry

    puts message
    #system command unless @options.dry
  end

end

