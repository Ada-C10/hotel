require_relative 'room'
require_relative 'reservation'
require 'date'

class Admin
  attr_reader :rooms, :reservations, :room_cost

  def initialize
    @rooms = Array.new(20)
      @rooms.length.times do |x|
        room_number = x + 1
        @rooms[x] = Room.new(room_number, :available)
      end
    @reservations = []
    @room_cost = 200
  end

  def add_reservation(reservation)
    @reservations << reservation
  end

  def request_reservation(start_date, end_date)
    id = reservations.length + 1
    room = select_room
    # binding.pry
    new_reservation = Reservation.new(id, room, start_date, end_date)

    # room_to_unavailable(room)
    add_reservation(new_reservation)
    return new_reservation
  end
  #param - date
  #returns - array of reservations within that date
  def reservations_by_date(date)
    @reservations.find_all do |reservation|
      (reservation.start_date..reservation.end_date).cover?(Date.parse(date))
    end
  end

  def reservation_cost(reservation)
    # https://stackoverflow.com/questions/4502245/how-can-i-find-the-number-of-days-between-two-date-objects-in-ruby
    start_date = reservation.start_date
    end_date = reservation.end_date
    total_nights = end_date.mjd - start_date.mjd

    cost = total_nights * @room_cost

    return cost
  end
  # need assign room when reservation is made
  def select_room
    room = @rooms.find { |room| room.status == :available }
    return room
  end

  # def room_to_unavailable(room)
  #   room.status = :unavialable
  # end
end
