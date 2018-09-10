require_relative 'reservation.rb'
require 'pry'

class BookingManager

  attr_reader :rooms
  attr_accessor :reservations, :start_date, :end_date, :make_reservation


  def initialize
    @start_date = start_date
    @end_date = end_date
    @reservations = []
    @rooms = []
    i = 0
    20.times do |i|
      @rooms << i + 1
      i += 1
    end

  end

  def find_available_room(start_date, end_date)
    requested_dates = (start_date...end_date).to_a
    room = 237
    room_count = 1
    while room_count < 20
      if @reservations.empty?
        room = 1
        return room
      end
      @reservations.each_with_index do |reservation, index|
        if reservation.room == (index + 1) && (reservation.reservation_dates & requested_dates).length == 0
          room = index + 1
          return room
        elsif reservation.room == (index + 1)
          room_count += 1
        elsif reservation.room != (index + 1)
          room = index + 1
          return room
        end
      end
    end
    raise StandardError.new("No room available")
  end
end

def make_reservation(start_date, end_date)
  start_date = @start_date
  end_date = @end_date

  room = find_available_room(start_date, end_date)
  if @rooms.include? room
    reservation = Reservation.new(room, start_date, end_date)
    @reservations << reservation
    binding.pry
    @make_reservation
  end
end
