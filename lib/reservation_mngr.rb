require 'pry'

require 'time'
require 'date'


require_relative 'reservation'

module Hotel

  class Reservation_mngr < Reservation

    attr_reader :rooms, :reservations
    attr_accessor :current_res_id

    def initialize
      @rooms = build_room_list
      @reservations = []
      @current_res_id = 1
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

    def create_reservation(check_in, check_out)
      raise ArgumentError if check_out == nil
      raise ArgumentError if check_in == nil
      raise ArgumentError if check_out < check_in
      raise ArgumentError if check_in > check_out

      room = find_room(check_in, check_out)
      reservation = Hotel::Reservation.new(reservation_id: @current_res_id, room: room, check_in: check_in, check_out: check_out)

      @reservations << reservation
      @current_res_id += 1
      return reservation
    end

    def get_total(reservation_id)
      raise ArgumentError if reservation_id.to_s !~ /\d/

      @reservations.each do |reservation|
        if reservation.reservation_id == reservation_id
          return reservation.calculate_cost
        end
      end
      return 1000
    end

  end
end
