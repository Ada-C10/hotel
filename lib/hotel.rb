require 'pry'

class Hotel
  def initialize
    @rooms = []
    set_up_rooms(20)
    @reservations = []
  end

  def set_up_rooms(number_of_rooms)
    number_of_rooms.times do |i|
      @rooms << Room.new(i + 1, 200)
    end
  end

  def room_list
    return @rooms
  end

  def make_reservation(start_date, end_date, room_number)
    available_room_list = find_available_rooms(start_date, end_date)
    raise ArgumentError, 'Room not available' unless available_room_list.include?(room_number)
    new_reservation = Reservation.new(start_date, end_date, find_room_by_number(room_number))
    @reservations << new_reservation
    add_reservation_to_room(new_reservation)
    return new_reservation
  end

  def find_room_by_number(number)
    room_list.find {|room| room.room_number == number}
  end

  def add_reservation_to_room(reservation)
    room = find_room_by_number(reservation.room_number)
    room.reservations << reservation
  end

  def find_reservations_by_date(date)
    @reservations.select {|reservation| reservation.checkin_date <= date && reservation.checkout_date >= date}
  end

  def find_available_rooms(start_date, end_date)
    available_room_numbers = []
    room_list.each do |room|
      room_is_available = true
      (start_date..end_date).each do |date|
        if !room.is_available?(date)
          room_is_available = false
        end
      end
      available_room_numbers << room.room_number if room_is_available
    end
    return available_room_numbers
  end



end
