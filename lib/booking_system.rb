require_relative 'room.rb'
require_relative 'reservation.rb'
require 'awesome_print'
require 'date'

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
    is_it_available = []
    @rooms.each do |room|
      dates_to_book.each do |date|
        if room.dates_booked.include?(date)
          is_it_available << "no"
        else
          is_it_available << "yes"
        end
      end
      if is_it_available.all?("yes")
        dates_to_book.each do |date|
          room.dates_booked << date
        end
        break
      end
    end
    return new_reservation
  end


  # access the list of reservations for a specific date

  # get the total cost for a given reservation
end
