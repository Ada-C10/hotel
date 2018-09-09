require_relative 'room'
require_relative 'reservation'


require 'date'
require 'pry'

class FrontDesk
  attr_reader :reservations, :rooms, :blocks

  def initialize
    @rooms = load_rooms
    @reservations = []
    @blocks = []

  end

  def load_rooms
    rooms = []
    20.times do |i|
      rooms << Room.new((i + 1))
    end
    return rooms
  end

  def list_all_rooms
    rooms.each do |room|
      room
    end
  end

  def create_reservation(room_number, start_day, end_day, nightly_cost)
     check_availability(room_number, start_day, end_day)
    new_reservation = Reservation.new(room_number, start_day, end_day,nightly_cost)
    reservations << new_reservation
    room = find_room(room_number)
    room.add_reservation_to_room(new_reservation)

  end

  def find_room(room_number)
    return @rooms.find {|room| room.room_number == room_number}
  end

  def find_by_date(date)
      res = []
      @reservations.each do |reservation|
        if reservation.start_day == Date.parse(date)
          res << reservation
      end
    end
    return res
  end

  def find_available_rooms(start_day, end_day)
    available_rooms = []
    @rooms.each do |room|
      room_is_available = true
      (start_day...end_day).each do |date|
        if !room.is_available?(date)
          room_is_available = false
        end
      end
      available_rooms << room.room_number if room_is_available
    end
    return available_rooms
  end

  def check_availability(room_number, start_day, end_day)
    available_rooms = find_available_rooms(Date.parse(start_day), Date.parse(end_day))
    raise StandardError, 'Room not available' unless available_rooms.include?(room_number)
  end


  def create_block(block_start, block_end, rate, block_rooms)
    find_available_rooms(block_start, block_end)
    block_rooms.each do |room_number|
      check_availability(room_number,block_start,block_end)
    end
    converted_rooms = block_room_list_to_room(block_rooms)
    new_block = Block.new(block_start, block_end, rate, converted_rooms)
    @blocks << new_block
    converted_rooms.each do |room|
      room.add_reservation_to_room(new_block)
    end
    return new_block
end

  def block_room_list_to_room (block_rooms)
    converted_rooms = []
    block_rooms.each do |room_number|
      converted_rooms << find_room(room_number)
    end
    return converted_rooms
  end


  def find_block_by_id(block_ID)
    return @blocks.find {|block| block.block_ID == block_ID}
  end

  def find_available_rooms_in_block(block_ID)
    available_rooms = []
    block = find_block_by_id(block_ID)
    rooms = block.converted_rooms
    @block_rooms.each do |room|
      room_is_available = true
      (block_start...block_end).each do |date|
        if !room.is_available?(date)
          room_is_available = false
        end
      end
      available_rooms << room.room_number if room_is_available
    end
    return available_rooms
  end


end
