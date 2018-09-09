require 'date'
require 'pry'
require_relative 'room'
require_relative 'reservation'
require_relative 'block_room'
require_relative 'helper_method'

module Hotel
  class Booking_Manager
    attr_reader :rooms, :hotel_reservations, :block_reservations

    ROOM_NUMBERS = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]
    ROOM_COST = 200.0

    def initialize
      @rooms = load_rooms
      @hotel_reservations = []
      @block_reservations = []
    end

    def reserve_room(input)
      search_all_rooms_availability(input[:check_in_date], input[:check_out_date])

      reserve = { name: input[:name],
        room_number: input[:room_number],
        check_in_date: input[:check_in_date],
        check_out_date: input[:check_out_date]
      }
      reservation = Hotel::Reservation.new(reserve)
      Hotel::Helper_Method.connect_reservation_to_room_and_sort(@rooms, input[:room_number], reservation)
      @hotel_reservations << reservation
      Hotel::Helper_Method.sort_reservations(@hotel_reservations)
    end

    def reserve_room_in_block(input)
      customer_name = input[:name]
      available_rooms_in_block = check_block_status(input[:block_name])
      available_rooms_in_block.first.name = customer_name
      available_rooms_in_block.first.block_reservation_status = :BOOKED
    end

    def create_block(input)
      check_in_date = input[:check_in_date]
      check_out_date = input[:check_out_date]
      vacant_rooms = []
      vacant_rooms = search_all_rooms_availability(check_in_date, check_out_date)
      number_of_rooms_to_block = input[:number_of_rooms_to_block]
      if number_of_rooms_to_block > 5
        return raise ArgumentError, 'Limit exceeded. Cannot create block larger than 5 rooms.'
      end
      blocked_rooms = []
      number_of_rooms_to_block.times do |i|
        block_room_hash = {
          room_number:  vacant_rooms[i],
          check_in_date: check_in_date,
          check_out_date: check_out_date,
          block_name: input[:block_name],
          block_discount: input[:block_discount]
        }
        reservation = Hotel::Block_Room.new(block_room_hash)
        Hotel::Helper_Method.connect_reservation_to_room_and_sort(@rooms, block_room_hash[:room_number], reservation)
        @hotel_reservations << reservation
        Hotel::Helper_Method.sort_reservations(@hotel_reservations)

        blocked_rooms << reservation
      end
      @block_reservations << blocked_rooms
    end

    def search_all_rooms_availability(check_in_date, check_out_date)
      possible_nights_of_stay = Hotel::Helper_Method.generate_nights(check_in_date, check_out_date)
      vacant_rooms = []
      @rooms.each do |room|
        if Hotel::Helper_Method.binary_search_list_of_reservations_for_vacancy(room.reservations, possible_nights_of_stay) == false
          vacant_rooms << room.room_number
        end
      end
      if vacant_rooms.empty?
        return raise ArgumentError, 'No Rooms Available in date range'
      end
      return vacant_rooms
    end

    def get_rooms
      return @rooms
    end

    def list_reservations(date)
      reservations = []
      @rooms.each do |room|
        index = Hotel::Helper_Method.binary_search_reservations_return_index_if_found(room.reservations,date)
        if index == nil
          next
        elsif
          reservations << room.reservations[index]
        end
      end
      if reservations.empty?
        return raise StandardError, "No rooms reserved on provided date."
      else
        return reservations
      end
    end

    def check_block_status(name_of_block)
      available_rooms = []
      name = name_of_block
      @block_reservations.each do |block|
        if block.first.block_name == name
          block.each do |reservation|
            if reservation.block_reservation_status == :AVAILABLE
              available_rooms << reservation
            end
          end
        end
      end
      if available_rooms.empty?
        return raise StandardError, "All rooms in block booked."
      else
        return available_rooms
      end
    end

    def total_cost_of_stay(reservation)
      cost = (reservation.nights_of_stay.length * ROOM_COST)
      if reservation.class == Hotel::Block_Room
        return (cost - (cost * reservation.block_discount))
      else
        return cost
      end
    end

    def load_rooms
      rooms = []
      ROOM_NUMBERS.each do |num|
        room = Room.new(num)
        rooms << room
      end
      return rooms
    end

  end
end
