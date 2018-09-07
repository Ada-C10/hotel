require_relative 'room'
require_relative 'reservation'
require 'date'

class Admin
  attr_reader :rooms, :reservations

  def initialize
    @rooms = Array.new(20)
      @rooms.length.times do |x|
        @rooms[x] = x + 1
      end
    # @rooms = Array.new(20)
    #   @rooms.length.times do |x|
    #     room_number = x + 1
    #     @rooms[x] = Room.new(room_number, :available)
    #   end
    @reservations = []
  end

  def add_reservation(reservation, reservation_location: @reservations)
    reservation_location << reservation
  end

  def request_reservation(start_date, end_date)
    id = reservations.length + 1
    room = available_rooms(start_date, end_date).sample
      if room.nil?
        raise ArgumentError, "no rooms available"
      end

    new_reservation = Reservation.new(id, room, start_date, end_date)

    add_reservation(new_reservation)
    return new_reservation
  end

  def request_block_reservation(number_of_rooms, start_date, end_date)
    if number_of_rooms > 5
      raise StandardError, "cannot reserve more than 5 rooms"
    end
    # individual reservations in block will be reached by going to block reservation first
    # individual reservations with have different id's (1-5) depending on size of block
    id = reservations.length + 1
    room = available_rooms(start_date, end_date).sample(number_of_rooms)
      if room.length < number_of_rooms
        raise StandardError, "not enough rooms available"
      end

    new_block = BlockReservation.new(id, room, start_date, end_date)

    add_reservation(new_block)

    return new_block
  end
  #param - date
  #returns - array of reservations within that date
  def reservations_by_date(date)
    specific_reservations = @reservations.find_all do |reservation|
      (reservation.start_date..reservation.end_date).cover?(Date.parse(date))
    end

    return specific_reservations
  end

  def reservations_by_date_range(trip_start, trip_end)
    trip_start = Date.parse(trip_start)
    trip_end = Date.parse(trip_end)

    @reservations.find_all do |reservation|
      unless reservation.end_date == trip_start
        (reservation.start_date..reservation.end_date).cover?(trip_start) || (reservation.start_date..reservation.end_date).cover?(trip_end)
      end
    end
  end

  def reservation_cost(reservation)
    # https://stackoverflow.com/questions/4502245/how-can-i-find-the-number-of-days-between-two-date-objects-in-ruby
    start_date = reservation.start_date
    end_date = reservation.end_date
    total_nights = end_date.mjd - start_date.mjd

    cost = total_nights * reservation.room_cost

    return cost
  end

  def available_rooms(trip_start, trip_end, all_rooms: [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20] )
    specific_reservations = reservations_by_date_range(trip_start, trip_end)
    # all_rooms = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20]
    unavailable_rooms = []
    # binding.pry
    specific_reservations.each do |reservation|
      unavailable_rooms << reservation.room
    end

    unavailable_rooms.flatten!
    available_rooms = all_rooms - unavailable_rooms
    return available_rooms
  end
end
