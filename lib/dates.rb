require 'date'
require 'pry'

class Dates
  attr_reader :date, :date_range

  def self.date_format(date)
    if date.class == Date
      return date
    else
      return Date.strptime(date, '%m-%d-%Y')
    end
  end


  def self.date_range_format(date_range)
    date_range[:begin_date] = date_format(date_range[:begin_date])

    date_range[:end_date] = date_format(date_range[:end_date])
    return date_range
  end
end
