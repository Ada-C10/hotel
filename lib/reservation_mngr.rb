require 'time'
require 'date'
require 'pry'


require_relative 'reservation'

module Hotel

  class ReservationManager < Reservation

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

    def check_dates(check_in, check_out)
      raise ArgumentError if check_out == nil
      raise ArgumentError if check_in == nil
      raise ArgumentError if check_out < check_in
      raise ArgumentError if check_in > check_out
    end

    def find_room(check_in, check_out)
      # find a way to use the find enumerable
      # rm_avail = true
      # @reservations.each do |reservation|
      #   if room.room_number == reservation.room.room_number
      #     if Date.strptime(check_in, '%m/%d/%Y') >= reservation.check_in && Date.strptime(check_out, '%m/%d/%Y') < reservation.check_out
      #       rm_avail = false
      #       break
      #     end
      #   else
      #     rm_avail = false
      #   end
      # end
      # if rm_avail
      #   return room
      # end
      check_in = Date.strptime(check_in, '%m/%d/%Y')
      check_out = Date.strptime(check_out, '%m/%d/%Y')

      unavailable = @reservations.collect do |reservation|
        if check_in >= reservation.check_in && check_in < reservation.check_out
          reservation.room
        end
      end
      if unavailable.length == 20
        return "No rooms available"
      else
        return @rooms[unavailable.length]
      end
    end

    def create_reservation(check_in, check_out)
      check_dates(check_in, check_out)
      room = find_room(check_in, check_out)
      reservation = Hotel::Reservation.new(room: room, check_in: check_in, check_out: check_out)


      if reservation.room.room_number < 1 && reservation.room.room_number > 20
        raise ArgumentError
      end
      @reservations << reservation
      return reservation
    end

    def get_total(room, check_in, check_out)
      @reservations.each do |reservation|
        if reservation.room.nil? || reservation.room.room_number < 1 || reservation.room.room_number > 20
          raise ArgumentError
        elsif reservation.room.room_number == room
          if check_in != reservation.check_in || check_out != reservation.check_out
            raise ArgumentError
          else
            date = reservation.check_out - reservation.check_in
            price = reservation.room.price
            return price * date
          end
        end
      end
    end

  end
end
