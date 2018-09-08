require_relative 'hotel_helper'

# class HotelManager retrieves and saves information about rooms and reservations
module Hotel
  class HotelManager
    attr_reader :rooms
    attr_accessor :reservations, :blocks

    # As an administrator, I can access the list of all of the rooms in the hotel
    def initialize(room_file = 'support/rooms.csv', reservations_file = 'support/reservations.csv', blocks_file = 'support/blocks.csv')
      @rooms = load_rooms(room_file)
      @reservations = load_reservations(reservations_file)
      @blocks = load_blocks(blocks_file)
    end

    # As an administrator, I can reserve an available room for a given date range
    # As an administrator, I can reserve a room from within a block
    def make_reservation(start_date: Date.today, end_date: Date.today + 2, group_name: "", num_of_rooms: 1)
      if !group_name.empty?
        new_block = create_a_block(group_name, start_date: start_date, end_date: end_date)
        final_list = new_block.room_list.keys
        num_of_rooms.times do |i|
          room_number = final_list[i]
          new_reservation = Reservation.new(room_number, start_date: start_date, end_date: end_date, room_rate: new_block.room_rate, group_name: group_name)
          new_block.room_list[room_number] = :UNAVAILABLE
          reservations << new_reservation
        end
      else
        room_list = Room.all_available_rooms(rooms, start_date: start_date, end_date: end_date)
        if room_list.length < num_of_rooms
          raise StandardError.new("Not enough available rooms for this date range. Only #{room_list.length} rooms available.")
        else
          num_of_rooms.times do |j|
            new_reservation = Reservation.new(room_list[j], start_date: start_date, end_date: end_date)
            Room.change_status_of_room(rooms, room_list[j], start_date: start_date, end_date: end_date)
            reservations << new_reservation
          end
        end
      end
    end

    # As an administrator, I can create a block of rooms
    def create_a_block(group_name, num_of_rooms: 5, start_date: Date.today, end_date: Date.today + 2, room_rate: 175)
      if num_of_rooms > 5
        raise ArgumentError.new("Only 5 rooms per block.")
      end

      list = Room.all_available_rooms(rooms, start_date: start_date, end_date: end_date)

      if list.length < num_of_rooms
        raise ArgumentError.new("Not enough rooms available. Only #{list.length} room(s) available.")
      else
        final_list = list[0...num_of_rooms]
      end

      new_block = Block.new(group_name, final_list, start_date: start_date, end_date: end_date, room_rate: room_rate)
      blocks << new_block

      final_list.each do |room_number|
        Room.change_status_of_room(rooms, room_number, start_date: start_date, end_date: end_date)
      end

      return final_list
    end

    # As an administrator, I can access the list of reservations for a specific date
    def find_reservations(date: Date.today)
      found_reservations = []

      if date.class != Date
        date = Date.parse(date)
      end

      reservations.each do |reservation|
        all_dates = DateRange.create_date_array(start_date: reservation.start_date, end_date: reservation.end_date)
        if all_dates.include? date
          found_reservations << reservation
        end
      end

      return found_reservations
    end

    # As an administrator, I can view a list of rooms that are not reserved for a given date range
    def find_available_rooms(rooms, start_date: Date.today, end_date: Date.today + 2)
      return Room.all_available_rooms(rooms, start_date: start_date, end_date: end_date)
    end

    # As an administrator, I can check whether a given block has any rooms available and view a list of these rooms
    def find_available_rooms_in_block(blocks, group_name)
      return Block.all_available_rooms_in_block(blocks, group_name)
    end

    def load_rooms(filename)
      all_rooms = []
      room_data = CSV.open(filename, 'r', headers: true, header_converters: :symbol)

      room_data.each do |room|
        new_room = Room.new(room[:id].to_i)
        all_rooms << new_room
      end

      return all_rooms
    end

    def load_reservations(filename)
      all_reservations = []
      reservation_data = CSV.open(filename, 'r', headers: true, header_converters: :symbol)

      reservation_data.each do |reservation|
        new_reservation = Reservation.new(reservation[:room_number].to_i, start_date: reservation[:start_date], end_date: reservation[:end_date])
        Room.change_status_of_room(rooms, reservation[:room_number].to_i, start_date: reservation[:start_date], end_date: reservation[:end_date])
        all_reservations << new_reservation
      end

      return all_reservations
    end

    def load_blocks(filename)
      all_blocks = []
      block_data = CSV.open(filename, 'r', headers: true, header_converters: :symbol)

      block_data.each do |block|
        room_list =  block[:room_list].split(",").map(&:to_i)
        new_block = Block.new(block[:group_name].to_s, room_list, start_date: block[:start_date], end_date: block[:end_date], room_rate: block[:room_rate].to_i)
        room_list.each do |room|
          Room.change_status_of_room(rooms, room, start_date: block[:start_date], end_date: block[:end_date])
        end
        all_blocks << new_block
      end

      return all_blocks
    end
  end
end
