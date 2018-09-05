require 'time'
require 'date'

class ReservationTracker
  attr_reader :all_rooms, :all_reservations

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
    return available_rooms
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
