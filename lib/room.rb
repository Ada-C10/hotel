require 'time'
require 'date'

class Room
  attr_reader :room_number, :dates_booked

  def initialize(room_number)
    @room_number = room_number
    @dates_booked = []
  end

  def is_available?(formatted_date)

    # formated_date = format_date(date)

    if @dates_booked.include?(formatted_date)
      return false
    else
      return true
    end
  end

  # def format_date(date_string)
  #
  #   parsed_date = date_string.split(",")
  #   year = parsed_date[0].to_i
  #   month = parsed_date[1].to_i
  #   day = parsed_date[2].to_i
  #   formated_date = Date.new(year,month,day)
  #
  #   return formated_date
  # end
end
