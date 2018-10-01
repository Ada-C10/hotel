require_relative 'reservation'
require_relative 'block_room'
require_relative 'date_range'
require 'awesome_print'

module Hotel
  class BookingSystem
    class ValidateRoomsError < StandardError ; end

    attr_reader :rooms, :reservations, :block_rooms

    def initialize
      @rooms = (1..20).to_a
      @reservations = []
      @block_rooms = []
    end

    def list_reservations(date_range)
      return @reservations.select { |res| res.date_range == date_range }
    end

    def list_available_rooms(date_range)
      return @rooms if @reservations.empty?
      return find_available_rooms(date_range)
    end

    def find_available_rooms(date_range)
      return @rooms if @reservations.empty?

      unavailable_rooms = @reservations.map {
        |res| res.room_number if date_range.dates_overlap?(res.date_range)
      }.flatten.compact


      unavailable_rooms_block = @block_rooms.map {
        |res| res.block_rooms if date_range.dates_overlap?(res.date_range)
      }.flatten.compact


      all_unavailable_rooms = unavailable_rooms + unavailable_rooms_block

      available_rooms = @rooms.reject {
        |r| all_unavailable_rooms.include?(r)
      }

      raise ValidateRoomsError, "No rooms available for those dates." if available_rooms.empty?
      return available_rooms
    end

    def make_reservation(date_range)
      room = find_available_rooms(date_range).first
      reservation = Reservation.new(date_range, room)
      @reservations << reservation
      return reservation
    end

    def reserve_block_rooms(date_range)
      rooms = find_available_rooms(date_range).first(5)
      block_reservation = BlockRoom.new(date_range, rooms)
      @block_rooms << block_reservation
      return block_reservation
    end

    def find_block(date_range)
      raise ValidateRoomsError, "No block rooms found for those dates" if @block_rooms.empty?
      return @block_rooms.select { |block| block.date_range == date_range }
    end

    def find_room_in_block(date_range)
      found_block = find_block(date_range)
      room_block_rooms = found_block.first.block_rooms
      available_rooms = find_available_rooms(date_range)
      rooms = available_rooms.select { |room| room if room_block_rooms.include? available_rooms }
      return rooms
    end

    def make_reservation_from_block(date_range)
      room = find_room_in_block(date_range).first
      reservation = Reservation.new(date_range, room)
      @reservations << reservation
      return reservation
    end


  end
end
