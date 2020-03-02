# Format tabular data using a named formatter.
#
# ```
# Operation::FormatData.call(data, "table", false)
# # => Calls: Formatter::Table.call(data, false)
# ```
#
# TODO: This could honestly just be a concern once FORMATTERS is moved to Formatter.all
class Stag::Operation::FormatData < Stag::Operation::Base

  def self.call(*arguments)
    new.call(*arguments)
  end

  # TODO: Formatter.all and Formatter.register
  # Then in inherited hook register the new sublass with macros
  FORMATTERS = {
    "text" => Formatter::TextTable
  }

  def call(data, name, params)
    formatter = FORMATTERS[name].not_nil! # TODO: UnknownFormatter error?
    formatter.call(data, params)
  end

end

