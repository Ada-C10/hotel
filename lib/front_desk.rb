require_relative "rooms.rb"
require_relative "reservations.rb"


class Front_Desk

  attr_reader :reservations, :rooms

  def initialize
    @reservations = []
    @rooms = load_rooms
  end

  def load_rooms
    room_number = 0
    rooms = []

    20.times do
      room_number += 1
      rooms << Room.new({
        :room_number => room_number
      })
    end
    return rooms
  end

  def reserve_room(room_number,start_date, end_date)

    available_rooms = available_rooms(start_date,end_date)
    if !available_rooms.find { |room| room.room_number == room_number }
      raise StandardError
    end

    input = {}
    input[:room_number] = room_number
    input[:start_date] = start_date
    input[:end_date] = end_date

    new_reservation = Reservation.new(input)
    @reservations << new_reservation

    return new_reservation
  end

  #method to grab reservation by Date
  def search_reserved_by_date(search_date)
    search_date = Date.parse(search_date)
    @reservations.select do |reservation|
      reservation.start_date <= search_date && search_date < reservation.end_date
    end
  end

  def available_rooms(start_date,end_date)
    start_date = Date.parse(start_date)
    end_date = Date.parse(end_date)

    list_of_rooms = @rooms.dup

    @reservations.each do |reservation|
      # if !(reservation.start_date < start_date) && !(reservation.end_date <= start_date) ||
      #    !(reservation.start_date < end_date) && !(reservation.end_date < end_date)

      if !((start_date < reservation.start_date && end_date <= reservation.start_date) ||
          # binding.pry
        (end_date > reservation.end_date && start_date >= reservation.end_date))
        list_of_rooms.reject! { |room| room.room_number == reservation.room_number }
      end
    end
    return list_of_rooms
  end

end
