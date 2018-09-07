require_relative 'room.rb'
require_relative 'reservation.rb'
require 'awesome_print'
require 'date'
require 'pry'

class BookingSystem
  attr_reader :num_rooms, :rooms, :reservations

  def initialize()
    @num_rooms = 20
    @rooms = load_rooms
    @reservations = []
  end

  def load_rooms
    rooms =[]
    @num_rooms.times { |room| rooms << Room.new(room_num: room + 1) }
    return rooms
  end

  # access the list of all of the rooms in the hotel
  def list_all_rooms
    return @rooms
  end

  # reserve a room for a given date range
  def reserve_room(start_date, end_date)
    dates = date_range(start_date, end_date)
    @rooms.each do |room|
      if room.is_available?(dates)
        room.add_booked_dates(dates)
        new_reservation = Reservation.new(start_date, end_date)
        @reservations << new_reservation
        return new_reservation
        break
      end
    end
  end

  def date_range(check_in_date, check_out_date)
    check_in_date = Date.parse(check_in_date)
    check_out_date = Date.parse(check_out_date)
    dates = []
    date = check_in_date
    while date < check_out_date
      dates << date
      date += 1
    end
    return dates
  end

  # access the list of reservations for a specific date
  def reservations_by_date(date)

  end

  # get the total cost for a given reservation
  def find_reservation(id)
  end
end
