require "date"

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
      all_rooms = nums.map { |num| Hotel::Room.new(num: num)}

      return all_rooms
    end

    def list_all_rooms()
      all_rooms_str = "Here is a list of all rooms: \n"

      @rooms.each do |room|
        all_rooms_str << "- Room #{room.num} \n"
      end

      return all_rooms_str
    end

# QUESTION: is this necessary??
    def create_reservation(input)
      room = find_room(input[:room_num])
      # start_date = input[:start_date]
      # end_date = input[:end_date]

      reservation_hash = {
        id: input[:id].to_i,
        room: room,
        start_date: input[:start_date],
        end_date: input[:end_date],
      }

      new_reservation = Reservation.new(reservation_hash)
      #NOTE: add room.change_status???
      room.add_reservation(new_reservation)

      return new_reservation
    end

    # QUESTION: NOT NEEDED-- JUST IN RESERVATION?
    # def add_reservation(new_reservation)
    #   @reservations << create_reservation(new_reservation)
    # end

    # QUESTION: add loading class or hold off? should be blank list at top?
    # def load_reservations(input)
    #   new_reservation = create_reservation()
    #   add_reservation(new_reservation)
    #   return @reservations
    # end


    def list_reservations_by_date(date)
      #TODO error handling for date as Date object??
      return res_by_date = @reservations.map { |reservation| reservation.date == date }
    end

    def find_room(room_num)
      return @rooms.find {|room| room.num == room_num.to_i}
    end

  end
end


# booking = Hotel::BookingSystem.new()
#
# puts booking.list_all_rooms
