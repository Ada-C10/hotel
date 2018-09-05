require 'time'
require 'date'

class ReservationTracker
  attr_reader :all_rooms

  def initialize()
    @all_rooms = []

    room_numbers = [*1..20]
    room_numbers.each do |room_num|
      new_room = Room.new(room_num)
      @all_rooms << new_room
    end

    @all_reservations = []
  end

  # date must be entered in the format: yyyy,mm,dd
  def show_available_rooms(start_date, end_date)
    available_rooms = []

    parsed_start_date = start_date.split(",")
    start_year = parsed_start_date[0].to_i
    start_month = parsed_start_date[1].to_i
    start_day = parsed_start_date[2].to_i
    starting_date = Date.new(start_year, start_month, start_day)

    parsed_end_date = end_date.split(",")
    end_year = parsed_end_date[0].to_i
    end_month = parsed_end_date[1].to_i
    end_day = parsed_end_date[2].to_i
    ending_date = Date.new(end_year, end_month, end_day)

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
  end

  def format_date(date_string)

  end

end
