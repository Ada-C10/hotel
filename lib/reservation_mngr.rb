require 'time'
require 'date'

module Hotel

  class Reservation_mngr
    attr_reader :rooms, :reservations

    def initialize
      @rooms = build_room_list
      @reservations = []
    end

    def build_room_list
      rooms = []
      20.times do |i|
        rooms << Hotel::Room.new({room_number: "#{i + 1}".to_i, price: 200})
      end
      return rooms
    end

    def find_room(check_in, check_out)
      return @rooms.first
      # availability = []
      # @rooms.length.times do |i|
      #   if @rooms[i][:check_in] !>= Date.strptime(check_in) && @rooms[i][:check_out] !< Date.strptime(check_out)
      #     availability << @rooms[i]
      #   end
      # end
      # return availability
    end

    # def create_reservation(check_in, check_out)
    #   room = find_room(check_in, check_out)
    #
    #   reservation = Reservation.new(...)
    #   @reservations << reservation
    #   return reservation
    # end
    #
    # def get_total(reservation_id)
    #
    # end

  end

end
