require 'time'
require 'date'

class Reservation
  attr_reader :reservation_num, :room_num, :start_date, :end_date, :room_type

  def initialize(reservation_num, room_num, start_date, end_date, room_type)
    @reservation_num = reservation_num.to_i

    # Verify valid room number entered
    all_room_numbers = [*1..20]
    if all_room_numbers.include?(room_num.to_i)
      @room_num = room_num.to_i
    else
      raise ArgumentError.new("Invalid room number entered.")
    end

    # start date must be entered in the format: yyyy,mm,dd
    parsed_start_date = start_date.split(",")
    start_year = parsed_start_date[0].to_i
    start_month = parsed_start_date[1].to_i
    start_day = parsed_start_date[2].to_i
    starting_date = Date.new(start_year, start_month, start_day)

    # end date must be entered in the format: yyyy,mm,dd
    parsed_end_date = end_date.split(",")
    end_year = parsed_end_date[0].to_i
    end_month = parsed_end_date[1].to_i
    end_day = parsed_end_date[2].to_i
    ending_date = Date.new(end_year, end_month, end_day)

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
end
