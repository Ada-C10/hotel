require 'date'
require 'pry'

class DateRange

  def self.date_parse(date)
    if date.class == Date
      return date
    else
      return Date.strptime(date, '%m-%d-%Y')
    end
  end


  def self.date_range_parse(date_range)
    date_range[:begin_date] = date_parse(date_range[:begin_date])

    date_range[:end_date] = date_parse(date_range[:end_date])

    raise ArgumentError, "Invalid dates. Begin date must be at least one day prior to end date." if date_range[:begin_date] > date_range[:end_date]

    return date_range
  end


  def self.date_overlap?(date_range_1, date_range_2)
    # if date_range_1[:end_date] > date_range_2[:begin_date] && date_range_1[:end_date] <= date_range_2[:end_date] ||
    #
    #   date_range_1[:begin_date] >= date_range_2[:begin_date] && date_range_1[:begin_date] < date_range_2[:end_date] ||
    #
    #   date_range_1[:begin_date] <= date_range_2[:begin_date] && date_range_1[:end_date] >= date_range_2[:end_date] ||
    #
    #   date_range_1[:begin_date] > date_range_2[:begin_date] && date_range_1[:end_date] < date_range_2[:end_date]
    #   return true
    return !(date_range_1[:end_date] <= date_range_2[:begin_date] || date_range_1[:begin_date] >= date_range_2[:end_date])
    # end
  end
end
