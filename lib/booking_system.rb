require_relative 'room'
require_relative 'reservation'

module Hotel
  class BookingSystem
    attr_accessor :rooms, :reservations
    def initialize()
      @rooms = load_rooms() #<-- array of all rooms
      @reservations = []
    end

# TODO: maybe separate load class?
    def load_rooms()
      nums = (1..20).to_a
      all_rooms = nums.map { |num| Hotel::Room.new(num)}

      return all_rooms
    end

    def list_all_rooms()
      all_rooms_str = "Here is a list of all rooms: \n"

      @rooms.each do |room|
        all_rooms_str << "- Room #{room.num} \n"
      end

      return all_rooms_str
    end

# QUESTION: ughhhh, inputtt??? this is not DRY
    def create_reservation(input)
      room = find_room(room_num)

      new_reservation = Reservation.new(input)
      new_reservation = Reservation.new(id, room, start_date, end_date, cost)
      return new_reservation
    end

    def add_reservation(reservation)
      @reservations << reservation
    end

    def load_reservations()
      new_reservation = create_reservation()
      add_reservation(new_reservation)
      return @reservations
    end


    def list_reservations_by_date(date)
      #TODO error handling for date as Date object??
      return res_by_date = @reservations.map { |reservation| reservation.date == date }
    end

    def find_room(room_num)
      return @rooms.map {|room| room.num == room_num}
    end

  end
end


# booking = Hotel::BookingSystem.new()
#
# puts booking.list_all_rooms
