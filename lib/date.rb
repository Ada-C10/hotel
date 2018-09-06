require 'pry'
require 'time'
require 'date'

class DateRange
  attr_reader :start_date, :end_date

  def initialize(start_date, end_date)
    @start_date = start_date
    @end_date = end_date
  end

  def get_date_range

    date_range = (Date.parse(@start_date)...Date.parse(@end_date))
    return date_range
  end

  def check_overlap(reserve_dates, requested_dates)

    return (reserve_dates.to_a & list_requested_dates.to_a).empty?
  end


  def duration_cal

    duration = Date.parse(@end_date) - Date.parse(@start_date)
    return duration
  end
end
