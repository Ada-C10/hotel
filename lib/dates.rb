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

    raise ArgumentError, "Invalid dates. Begin date must be at least one day prior to end date." if date_range[:begin_date] > date_range[:end_date]

    return date_range
  end


  def self.date_range_comparison(date_range_1, date_range_2)
    if date_range_1[:end_date] > date_range_2[:begin_date] && date_range_1[:end_date] <= date_range_2[:end_date] ||

      date_range_1[:begin_date] >= date_range_2[:begin_date] && date_range_1[:begin_date] < date_range_2[:end_date] ||

      date_range_1[:begin_date] <= date_range_2[:begin_date] && date_range_1[:end_date] >= date_range_2[:end_date] ||

      date_range_1[:begin_date] > date_range_2[:begin_date] && date_range_1[:end_date] < date_range_2[:end_date]
      return true
    end
  end
end
