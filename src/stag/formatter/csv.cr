class Stag::Formatter::CSV < Stag::Formatter::Base

  class Params < Formatter::Params

    property separator

    def initialize(@separator = ",")
    end

  end

  @data : Array(Array(String))

  def initialize(@data, @params = Params.new)
  end

  def call
    ::CSV.build(@params.separator) do |csv|
      @data.each do |data_row|
        csv.row do |csv_row|
          data_row.each { |item| csv_row << item }
        end
      end
    end
  end

end

