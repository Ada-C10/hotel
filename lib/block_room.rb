require_relative 'lib_file_helper'

class BlockRoom
  attr_accessor :event_name, :start_date, :end_date, :rooms_blocked
  
  def initialize(event_name, start_date, end_date, rooms_blocked)
    @event_name = event_name

    # date must be entered in the format: yyyy,mm,dd
    @starting_date = format_date(start_date)
    @ending_date = format_date(end_date)

    @rooms_blocked = rooms_blocked
  end

  def format_date(date_string)
    parsed_date = date_string.split(",")
    year = parsed_date[0].to_i
    month = parsed_date[1].to_i
    day = parsed_date[2].to_i
    formatted_date = Date.new(year, month, day)

    return formatted_date
  end
end
