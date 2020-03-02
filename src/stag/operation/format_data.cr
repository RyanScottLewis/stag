# Format tabular data using a named formatter.
#
# ```
# Operation::FormatData.call(data, "table", false)
# # => Calls: Formatter::Table.call(data, false)
# ```
class Stag::Operation::FormatData < Stag::Operation::Base

  def self.call(*arguments)
    new.call(*arguments)
  end

  def call(data, name, params)
    # TODO: UnknownFormatter error? Maybe a Formatter.[] method that takes care of this
    formatter = Formatter.all[name].not_nil!
    formatter.call(data, params)
  end

end

