require 'time'
require 'date'

class Room
  attr_reader :room_number, :dates_booked

  def initialize(room_number)
    @room_number = room_number
    @dates_booked = []
  end

  # date must be entered in the format: yyyy,mm,dd
  def is_available?(date)

    parsed_date = date.split(",")
    year = parsed_date[0].to_i
    month = parsed_date[1].to_i
    day = parsed_date[2].to_i
    formated_date = Date.new(year,month,day)

    if @dates_booked.include?(formated_date)
      return false
    else
      return true
    end
  end
end
