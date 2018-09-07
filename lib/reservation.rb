require 'time'
require 'date'

class Reservation
  attr_accessor :reservation_num, :room_num, :start_date, :end_date, :room_type, :dates_booked_for_reservation

  def initialize(reservation_num, room_num, start_date, end_date, room_type)
    @reservation_num = reservation_num.to_i

    # Verify valid room number entered
    all_room_numbers = [*1..20]
    if all_room_numbers.include?(room_num.to_i)
      @room_num = room_num.to_i
    else
      raise ArgumentError.new("Invalid room number entered.")
    end

    # Verifying valid date ranges entered
    if end_date - start_date >= 1
      @start_date = start_date
      @end_date = end_date
    else
      raise ArgumentError.new("Invalid date range entered")
    end

    # Verifying valid room_type is entered
    if room_type == :standard || room_type == :block
      @room_type = room_type
    else
      raise ArgumentError.new("Invalid room type entered")
    end

    # Recording the dates that the reservation is made for
    @dates_booked_for_reservation = dates_of_booking(@start_date, @end_date)
  end

  def dates_of_booking(checkin, checkout)
    dates_for_booking = []

    duration_of_booking = checkout - checkin

    booking_date = checkin
    while booking_date < checkout
      dates_for_booking << booking_date
      booking_date += 1
    end

    return dates_for_booking
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
