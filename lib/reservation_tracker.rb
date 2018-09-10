require_relative 'lib_file_helper'

class ReservationTracker
  attr_accessor :all_rooms, :all_reservations

  def initialize()
    # @all_rooms is a collection of all room instances
    @all_rooms = room_factory
    # @all_reservations is a collection of all reservation instances
    @all_reservations = []
  end

  def room_factory
    all_rooms = []

    room_numbers = [*1..20]
    room_numbers.each do |room_num|
      new_room = Room.new(room_num)
      all_rooms << new_room
    end
    return all_rooms
  end

  def show_all_hotel_rooms
    return @all_rooms
  end

  def show_all_reservations
    return @all_reservations
  end

  def format_date(date_string)
    parsed_date = date_string.split(",")
    year = parsed_date[0].to_i
    month = parsed_date[1].to_i
    day = parsed_date[2].to_i
    formatted_date = Date.new(year, month, day)

    return formatted_date
  end

  def is_date_range_valid(start_date, end_date)
    if end_date - start_date >= 1
      return true
    else
      raise StandardError.new("Invalid date range entered.")
    end
  end

  def show_reservations_per_date(date)
    reservations_for_date = []
    formatted_date = format_date(date)

    # Iterating through all reservation instances listed in @all_reservations
    @all_reservations.each do |reservation|
      # reservation_dates is a collection of date instances for the specific reservation instance
      reservation_dates = reservation.dates_booked_for_reservation

      # If the reservation_dates collection includes the specified date, then that reservation instance is pushed into reservations_for_date
      if reservation_dates.include?(formatted_date)
        reservations_for_date << reservation
      end
    end
    return reservations_for_date
  end

  # Expecting user will enter date in the format: "yyyy,mm,dd"
  def show_available_rooms(start_date, end_date)
    starting_date = format_date(start_date)
    ending_date = format_date(end_date)

    if is_date_range_valid(starting_date, ending_date)
      available_rooms = []

      # This loop will iterate through each room instance listed in @all_rooms
      date_to_check = starting_date
      @all_rooms.each do |room|
        room_status = []

        # This loop will examine each room instance's @dates_booked collection (using Room.is_available?) and check if it is booked for each date that is being iterated through (using date_to_check += 1). If the room is NOT booked for the specified date then 'true' is pushed into room_status. If the room IS booked then 'false' is pushed into room_status.
        until date_to_check == ending_date
          check = room.is_available?(date_to_check)
          if check
            room_status << true
          else
            room_status << false
          end
          date_to_check += 1
        end

        # If the specific room instance is NOT booked (available) for all of the dates checked, then the room is pushed into available_rooms.
        if room_status.all?
          available_rooms << room
        end
      end
      # returning room instances NOT room numbers
      return available_rooms
    end
  end

  def update_dates_booked_for_room(new_reservation)
    dates_booked_for_new_reservation = new_reservation.dates_booked_for_reservation

    # Iterating through all room instances in @all_rooms. If the room instance has the same room number as the room_num in the reservation instance, then date instances representing all dates that the reservation is made for will be pushed into that room instance's @dates_booked
    @all_rooms.each do |room|
      if room.room_number == new_reservation.room_num
        dates_booked_for_new_reservation.each do |date|
          room.dates_booked << date
        end
      end
    end
  end

  def make_reservation_number
    reservation_number = @all_reservations.length + 1
    return reservation_number
  end

  # Expecting user will enter date in the format: "yyyy,mm,dd"
  def reserve_room(room_num, check_in, check_out)
    room_number = room_num.to_i
    start_date = format_date(check_in)
    end_date = format_date(check_out)

    if is_date_range_valid(start_date, end_date)
      # available_rooms is a collection of all room instances that are available for the given start and end date
      available_rooms = show_available_rooms(check_in, check_out)
      # available_rooms_by_number is a collection of all room numbers that are available for the given start and end date
      available_rooms_by_number = available_rooms.map do |room_instance|
                                  room_instance.room_number.to_i
                                end
      # If the available_rooms_by_number collection contains the desired room_number that the user wants to reserve, then create a new reservation
      if available_rooms_by_number.include?(room_number)
        reservation_number = make_reservation_number
        new_reservation = Reservation.new(reservation_number, room_number, start_date, end_date, :standard)

        update_dates_booked_for_room(new_reservation)
        @all_reservations << new_reservation

      else
        raise StandardError.new("The specified room is not available for the date range provided")
      end
    end
  end

  def cost_of_reservation(reservation_number)
    @all_reservations.each do |reservation|
      if reservation.reservation_num == reservation_number.to_i
        return reservation.total_cost
      end
    end
  end

# Wave 3 not complete. Need to change show_available_rooms to search through each room instances @dates_booked AND @dates_held_for_block. Currently, show_available_rooms is only searching @date_booked. Modify update_dates_booked_for_room to move date instance from @dates_held_for_block to @dates_booked.
def create_block(event_name, start, ending)
  rooms_for_block = []

  all_rooms_available = show_available_rooms(start, ending)

  if all_rooms_available.length >= 5
    5.times do |iterator|
      rooms_for_block << all_rooms_available[iterator]
    end
  else
    raise StandardError.new("There are not enough rooms available for the given date range to create a block")
  end

  return BlockRoom.new(event_name, start, ending, rooms_for_block)
end

end
