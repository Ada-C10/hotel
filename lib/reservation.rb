require 'time'
require 'date'

class Reservation
  attr_accessor :reservation_num, :room_num, :start_date, :end_date, :room_type

  def initialize(reservation_num, room_num, start_date, end_date, room_type)
    @reservation_num = reservation_num.to_i

    # Verify valid room number entered
    all_room_numbers = [*1..20]
    if all_room_numbers.include?(room_num.to_i)
      @room_num = room_num.to_i
    else
      raise ArgumentError.new("Invalid room number entered.")
    end

    # dates must be entered in the format: yyyy,mm,dd
    starting_date = format_date(start_date)
    ending_date = format_date(end_date)

    # Verifying valid date ranges entered
    if ending_date - starting_date >= 1
      @start_date = starting_date
      @end_date = ending_date
    else
      raise ArgumentError.new("Invalid date range entered")
    end

    # Verifying valid room_type is entered
    if room_type == :standard || room_type == :block
      @room_type = room_type
    else
      raise ArgumentError.new("Invalid room type entered")
    end
  end

  # A standard room is $200/night and a block room is $150/night
  def total_cost
    trip_duration = duration

    if @room_type == :standard
      total_price = trip_duration * 200
    else
      total_price = trip_duration * 150
    end
    return total_price
  end

  # Helper method to total_cost
  def duration
    reservation_duration = @end_date - @start_date
    return reservation_duration
  end

  # Helper method to the constructor
  def format_date(date_string)
    parsed_date = date_string.split(",")
    year = parsed_date[0].to_i
    month = parsed_date[1].to_i
    day = parsed_date[2].to_i
    formatted_date = Date.new(year, month, day)

    return formatted_date
  end
end
