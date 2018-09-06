require 'time'
require 'date'
require 'pry'

class ReservationTracker
  attr_accessor :all_rooms, :all_reservations

  def initialize()
    @all_rooms = []

    room_numbers = [*1..20]
    room_numbers.each do |room_num|
      new_room = Room.new(room_num)
      @all_rooms << new_room
    end

    @all_reservations = []
  end

  def show_all_hotel_rooms
    return @all_rooms
  end

  def show_all_reservations
    return @all_reservations
  end
  # date must be entered in the format: yyyy,mm,dd
  def show_available_rooms(start_date, end_date)
    available_rooms = []

    starting_date = format_date(start_date)
    ending_date = format_date(end_date)

    number_of_consecutive_days_to_check = ending_date - starting_date

    date_to_check = starting_date
    @all_rooms.each do |room|
      room_status = []

      until date_to_check == ending_date
        check = room.is_available?(date_to_check)

        if check
          room_status << true
        else
          room_status << false
        end

        date_to_check += 1
      end

      if room_status.all?
        available_rooms << room
      end
    end
    # returning room instances NOT room numbers
    return available_rooms
  end

  # date must be entered in the format: yyyy,mm,dd
  def reserve_room(room_num, start_date, end_date)
    room_number = room_num.to_i

    available_rooms = show_available_rooms(start_date, end_date)
    available_rooms_by_number = available_rooms.map do |room_instance|
                                room_instance.room_number.to_i
                              end
    if available_rooms_by_number.include?(room_number)
      reservation_number = make_reservation_number
      new_reservation = Reservation.new(reservation_number, room_number, start_date, end_date, :standard)
      @all_reservations << new_reservation

    else
      raise ArgumentError.new("The specified room is not available for the date range provided")
    end
  end

  def make_reservation_number
    reservation_number = @all_reservations.length + 1
    return reservation_number
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
