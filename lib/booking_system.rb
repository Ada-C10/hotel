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
    @num_rooms.times { |room| rooms << Room.new(room + 1)}
    return rooms
  end

  # access the list of all of the rooms in the hotel
  def list_all_rooms
    return @rooms
  end

  # reserve a room for a given date range
  def reserve_room(start_date, end_date)
    new_reservation = Reservation.new(start_date, end_date)
    dates_to_book = new_reservation.reservation_dates
    @rooms.each do |room|
      if room.is_available?(dates_to_book)
        add_booked_dates(dates_to_book)
        break
      end
    end
    @reservations << new_reservation
    return @reservations
  end

  # access the list of reservations for a specific date
  def reservations_by_date(date)

  end

  # get the total cost for a given reservation
  def find_reservation(id)
  end
end
