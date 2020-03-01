class Stag::Formatter::CSV < Stag::Formatter::Base

  @data : Array(Array(String))

  def initialize(@data, @separator = ',')
  end

  def call
    ::CSV.build(@separator) do |csv|
      @data.each do |data_row|
        csv.row do |csv_row|
          data_row.each { |item| csv_row << item }
        end
      end
    end
  end

end

