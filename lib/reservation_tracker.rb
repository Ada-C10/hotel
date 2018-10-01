require 'csv'

require_relative 'date_range'
require_relative 'reservation'
require_relative 'room'
require_relative 'block'

NUM_OF_ROOMS = 20
MAX_BLOCK_NUM = 5

module Hotel
  class ReservationTracker
    attr_reader :rooms, :blocks, :reservations

    def initialize(room_file = 'support/rooms.csv', block_file = 'support/blocks.csv', reservation_file = 'support/reservations.csv')
      @rooms = load_rooms(room_file)
      @blocks = load_blocks(block_file)
      @reservations = load_reservations(reservation_file)
    end

    def load_rooms(filename)
      rooms = []

      CSV.read(filename, headers: true).each do |line|

        input_data = {}
        input_data[:room_num] = line[0].to_i
        input_data[:rate] = line[1].to_i

        room = Room.new(input_data)
        rooms << room
      end
      return rooms
    end

    def load_blocks(filename)
      blocks = []
      block_data = CSV.open(filename, 'r', headers: true, header_converters: :symbol)

      block_data.each do |raw_block|
        start_date = Date.parse(raw_block[:start_date])
        end_date = Date.parse(raw_block[:end_date])

        requested_qty = raw_block[:party].to_i
        block_qty_rooms = @rooms.take(requested_qty)
        requested_dates = DateRange.new(start_date, end_date)

        parsed_block = {
          id: raw_block[:id].to_i,
          party: block_qty_rooms,
          date_range: requested_dates
        }

        block = Block.new(parsed_block)
        blocks << block
      end
      return blocks
    end

    def load_reservations(filename)
      reservations = []
      reservation_data = CSV.open(filename, 'r', headers: true, header_converters: :symbol)

      reservation_data.each do |raw_reservation|
        block_id = find_block_id(raw_reservation[:block_id].to_i)
        room = find_room(raw_reservation[:room].to_i)

        start_date = Date.parse(raw_reservation[:start_date])
        end_date = Date.parse(raw_reservation[:end_date])

        range = DateRange.new(start_date, end_date)

        parsed_reservation = {
          id: raw_reservation[:id].to_i,
          block_id: block_id,
          room: room,
          date_range: range
        }

        reservation = Reservation.new(parsed_reservation)
        reservations << reservation
      end
      return reservations
    end

    def find_block_id(id)
      check_id(id)
      return @blocks.find { |block| block.id == id }
    end

    def find_room(room_num)
      check_room_num(room_num)
      return @rooms.find { |room| room.room_num == room_num }
    end

    def list_reservations_by_date(specified_date)
      reservations_by_date = @reservations.find_all do |reservation|
        date_range = reservation.date_range.get_range
        date_range.include?(specified_date)
      end
      return reservations_by_date
    end

    def reservations_overlaps?(requested_dates)
      matching_reservations = @reservations.find_all do |reservation|
        date_range = reservation.date_range
        reservation if date_range.overlaps?(requested_dates)
      end
    end

    def find_reserved_rooms(requested_dates)
      matching_reservations = reservations_overlaps?(requested_dates)

      reserved_rooms = matching_reservations.map do |reservation|
        reservation.room
      end
      return reserved_rooms
    end

    def find_blocks(requested_dates)
      blocks_by_date = @blocks.map do |room|
        date_range = room.date_range
        room if date_range.overlaps?(requested_dates)
      end
      return blocks_by_date.compact
    end

    def find_unavailable_rooms(requested_dates)
      reserved_rooms = find_reserved_rooms(requested_dates)
      blocks = find_blocks(requested_dates)
      unavailable_rooms = reserved_rooms + blocks
      return unavailable_rooms
    end

    def find_available_rooms(requested_dates)
      unavailable_rooms = find_unavailable_rooms(requested_dates)
      available_rooms = @rooms.reject { |room| unavailable_rooms.include?(room) }
      check_availablity?(available_rooms)
      return available_rooms
    end

    def get_first_available_room(requested_dates)
      all_available_rooms = find_available_rooms(requested_dates)
      first_available_room = all_available_rooms.first
      return first_available_room
    end

    def get_requested_dates(start_date, end_date)
      return DateRange.new(start_date, end_date)
    end

    def reserve_room(input)
      requested_dates = get_requested_dates(input[:start_date], input[:end_date])

      reservation_id = @reservations.length + 1
      block_id = input[:block_id]
      room = get_first_available_room(requested_dates)

      reservation_data = {
        id: reservation_id,
        block_id: block_id,
        room: room,
        date_range: requested_dates
      }

      new_reservation = Reservation.new(reservation_data)
      @reservations << new_reservation
      return new_reservation
    end

    def confirm_valid_qty?(requested_qty)
      check_valid_num?(requested_qty)
      check_num_requested?(requested_qty)
    end

    def get_blocks(requested_qty, requested_dates)
      confirm_valid_qty?(requested_qty)
      available_rooms = find_available_rooms(requested_dates)
      check_enough_rooms?(available_rooms, requested_qty)
      block = available_rooms.take(requested_qty)
      return block
    end

    def block_rooms(input)
      requested_dates = get_requested_dates(input[:start_date], input[:end_date])
      block_id = @blocks.length + 1
      blocked_qty_rooms = get_blocks(input[:party], requested_dates)

      block_data = {
        id: block_id,
        party: blocked_qty_rooms,
        date_range: requested_dates
      }

      new_block = Block.new(block_data)
      @blocks << new_block
      return new_block
    end

    private

    class OldStartDateError < StandardError; end
    class InvalidDateError < StandardError; end
    class DatesOrderError < StandardError; end
    class NoRoomsError < StandardError; end
    class InvalidAmountRoomsError < StandardError; end
    class TooManyRoomsError < StandardError; end
    class NotEnoughError < StandardError; end

    def check_id(id)
      unless id.nil? || id >= 0
        raise ArgumentError, "ID cannot be less than zero. (got #{id})"
      end
    end

    def check_room_num(num)
      raise ArgumentError, "Room num cannot be less than 1 or greater than #{NUM_OF_ROOMS} (got #{num})" if num <= 0 || num > NUM_OF_ROOMS
    end

    def check_enough_rooms?(available_rooms, qty)
      if available_rooms.length < qty
        raise NotEnoughError.new("There are not enough rooms to block")
      end
    end

    def check_valid_num?(num)
      if !num.is_a?(Integer) || num <= 0
        raise InvalidAmountRoomsError.new("That is not a valid amount to request to block")
      end
    end

    def check_num_requested?(num)
      if num > MAX_BLOCK_NUM
        raise TooManyRoomsError.new("Cannot block more than 5 rooms")
      end
    end

    def check_availablity?(available_rooms)
      raise NoRoomsError.new("NO ROOMS AVAILABLE!!!") if available_rooms.empty?
    end
  end
end
