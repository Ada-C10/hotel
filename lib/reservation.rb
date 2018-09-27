require_relative 'lib_file_helper'
require 'date'

class Reservation
  attr_accessor :reservation_num, :room_instance, :room_num, :start_date, :end_date, :room_type, :dates_booked_for_reservation

  def initialize(room_instance, room_num, start_date, end_date, room_type)
    @reservation_num = generate_reservation_number
    @room_instance = room_instance

    if is_room_num_valid(room_num)
      @room_num = room_num.to_i
    end

    if is_date_range_valid(start_date, end_date)
      @start_date = start_date
      @end_date = end_date
    end

    if is_room_type_valid(room_type)
      @room_type = room_type
    end

    @dates_booked_for_reservation = dates_of_booking(@start_date, @end_date)


  end

  # Verifying that the room number entered is between 1-20
  def is_room_num_valid(room_num)
    all_room_numbers = [*1..20]
    if all_room_numbers.include?(room_num.to_i)
      return true
    else
      raise StandardError.new("Invalid room number entered.")
    end
  end

  # Verifying that the end_date is after the start date AND ensuring that the reservation is at least for 1 full day (across two separate days)
  def is_date_range_valid(start_date, end_date)
    if end_date - start_date >= 1
      return true
    else
      raise StandardError.new("Invalid date range entered")
    end
  end

  # Verifying that a valid room type is entered. This is needed for calculating total_cost.
  def is_room_type_valid(room_type)
    if room_type == :standard || room_type == :block
      return true
    else
      raise StandardError.new("Invalid room type entered")
    end
  end

  # Recording the range of dates that the reservation is for
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
    cost_per_night = @room_instance.price_per_night(@room_type)
    total_price = trip_duration * cost_per_night

    return total_price
  end

  # Helper method to total_cost
  def duration
    reservation_duration = @end_date - @start_date
    return reservation_duration
  end

  def update_room_booked_dates
    @room_instance.update_dates_booked_for_room(@dates_booked_for_reservation)
  end

  def generate_reservation_number
    room_num_string = @room_num.to_s
    date_time_object = DateTime.now
    date_time_string = date_time_object.strftime "%m%d%Y%H%M"
    reservation_number = room_num_string + date_time_string
    return reservation_number
  end

end
