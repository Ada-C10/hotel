require_relative 'date_range'
require_relative 'reservation'
require_relative 'room'

NUM_OF_ROOMS = 20
MAX_BLOCK_NUM = 5

module Hotel
  class ReservationTracker
    class InvalidDateError < StandardError; end
    class DatesOrderError < StandardError; end
    class NoRoomsError < StandardError; end
    class InvalidAmountRoomsError < StandardError; end
    class TooManyRoomsError < StandardError; end
    class NotEnoughError < StandardError; end

    attr_reader :rooms, :reservations, :blocked_rooms

    def initialize
      @rooms = load_rooms
      @reservations = []
      @blocked_rooms = []
    end

    def load_rooms
      all_rooms = []
      NUM_OF_ROOMS.times do |i|
        all_rooms << Hotel::Room.new(room_num: i + 1)
      end
      return all_rooms
    end

    def list_reservations_by_date(specified_date)
      reservations_by_date = @reservations.find_all do |reservation|
        range = reservation.date_range.get_range
        range.include?(specified_date)
      end
      return reservations_by_date
    end

    def reservations_overlaps?(requested_dates)
      matching_reservations = @reservations.find_all do |reservation|
        range = reservation.date_range
        range.overlaps?(requested_dates)
        reservation
      end
    end

    def find_reserved_rooms(requested_dates)
      matching_reservations = reservations_overlaps?(requested_dates)
      reserved_rooms = matching_reservations.map do |reservation|
        reservation.room
      end
      return reserved_rooms
    end

    def find_blocked_rooms(requested_dates)
      blocked_rooms_by_date = @blocked_rooms.map do |room|
        if room.date_range.get_range == requested_dates.get_range
          room.party
        end
      end
      return blocked_rooms_by_date.flatten
    end

    def find_unavailable_rooms(requested_dates)
      reserved_rooms = find_reserved_rooms(requested_dates)
      blocked_rooms = find_blocked_rooms(requested_dates)
      unavailable_rooms = reserved_rooms + blocked_rooms
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

    def confirm_valid_dates?(input)
      check_dates_validity?(input[:start_date], input[:end_date])
      check_dates_order?(input[:start_date], input[:end_date])
    end

    def get_requested_dates(input)
      confirm_valid_dates?(input)
      return DateRange.new(input[:start_date], input[:end_date])
    end

    def reserve_room(input)
      requested_dates = get_requested_dates(input)

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

    def get_blocked_rooms(requested_qty, requested_dates)
      confirm_valid_qty?(requested_qty)
      available_rooms = find_available_rooms(requested_dates)
      check_enough_rooms?(available_rooms, requested_qty)
      block = available_rooms.take(requested_qty)
      return block
    end

    def block_rooms(input)
      requested_dates = get_requested_dates(input)
      block_id = @blocked_rooms.length + 1
      blocked_qty_rooms = get_blocked_rooms(input[:party], requested_dates)

      block_data = {
        id: block_id,
        party: blocked_qty_rooms,
        date_range: requested_dates
      }

      new_block = Block.new(block_data)
      @blocked_rooms << new_block
      return new_block
    end

    private
    
    def check_dates_validity?(start_date, end_date)
      unless (start_date.is_a?(Date) && end_date.is_a?(Date))
        raise InvalidDateError.new("That is not a Date type")
      end
    end

    def check_dates_order?(start_date, end_date)
      unless start_date < end_date
        raise DatesOrderError.new("Start date must be before end date")
      end
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
