require_relative 'lib_file_helper'

class ReservationTracker
  attr_accessor :all_rooms, :all_reservations

  def initialize()
    @all_rooms = room_maker
    @all_reservations = []
  end

  def room_maker
    all_rooms = []

    room_numbers = [*1..20]
    room_numbers.each do |room_num|
      new_room = Room.new(room_num)
      all_rooms << new_room
    end
    return all_rooms
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

    @all_reservations.each do |reservation|
      # reservation_dates is a collection of date instances for the specific reservation instance
      reservation_dates = reservation.dates_booked_for_reservation

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

  # Finds a room instance with the matching room_number
  def room_instance(room_num)
    @all_rooms.each do |room|
      if room.room_number == room_num.to_i
        return room
      end
    end
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
        room_object = room_instance(room_number)
        new_reservation = Reservation.new(room_object, room_number, start_date, end_date, :standard)

        @all_reservations << new_reservation

      else
        raise StandardError.new("The specified room is not available for the date range provided")
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

    return BlockRoom.new(event_name, start, ending, rooms_for_block)
  else
    return false
  end
end

end
