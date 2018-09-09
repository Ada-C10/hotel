require_relative 'room.rb'
require_relative 'reservation.rb'
require 'awesome_print'
require 'date'
require 'pry'

class BookingSystem
  attr_reader :num_rooms, :rooms, :reservations, :room_blocks

  def initialize()
    @num_rooms = 20
    @rooms = load_rooms
    @reservations = []
    @room_blocks = []
  end

  def load_rooms
    rooms =[]
    @num_rooms.times { |room| rooms << Room.new(room_num: room + 1) }
    return rooms
  end

  # access the list of all of the rooms in the hotel
  def list_all_rooms
    return @rooms
  end

  # reserve a room for a given date range
  def reserve_room(check_in, check_out)
    dates = date_range(check_in, check_out)
    new_reservation = nil
    @rooms.each do |room|
      if room.is_available?(dates) && room.is_not_blocked?(dates)
        new_reservation = Reservation.new(check_in, check_out)
        new_reservation.id = assign_res_id
        room.add_reservation_to_room(new_reservation)
        @reservations << new_reservation
        break
      end
    end
    if new_reservation != nil
      return new_reservation
    else
      raise ArgumentError, 'no rooms available in date range'
    end
  end

  def date_range(check_in_date, check_out_date)
    check_in_date = Date.parse(check_in_date)
    check_out_date = Date.parse(check_out_date)
    dates = []
    date = check_in_date
    while date < check_out_date
      dates << date
      date += 1
    end
    return dates
  end

  def assign_res_id
    return @reservations.count + 1
  end

  # access the list of reservations for a specific date
  def reservations_by_date(date)
    date = Date.parse(date)
    list_res = []
    @reservations.each do |reservation|
      if reservation.check_in_date <= date && reservation.check_out_date >= date
        list_res << reservation
      end
    end
    return list_res
  end

  # get the total cost for a given reservation
  def total_cost_of_reservation(search_id)
    if reservation = @reservations.find { |res| res.id == search_id}
      return reservation.total_cost
    else
      return nil
    end
  end

  # view a list of rooms that are not reserved for a given date range
  def unreserved_rooms_by_date(start_date, end_date)
    dates = date_range(start_date, end_date)
    dates << Date.parse(end_date)
    unreserved_rooms = []
    @rooms.each do |room|
      if room.is_available?(dates) && room.is_not_blocked?(dates)
        unreserved_rooms << room
      end
    end
    return unreserved_rooms
  end

  # create block of rooms
  def create_block_of_rooms(start_date, end_date, discounted_rate)
    dates = date_range(start_date, end_date)
    new_block = BlockOfRooms.new(start_date, end_date, room_cost: discounted_rate)
    new_block.id = assign_block_id

    num_of_rooms = 0
    @rooms.each do |room|
      if room.is_available?(dates) && room.is_not_blocked?(dates)
        room.add_block_to_room(new_block)
        new_block.add_room(room)
        num_of_rooms += 1
      end
      if num_of_rooms == 5
        break
      end
    end

    @room_blocks << new_block

    return new_block
  end

  def assign_block_id
    return @room_blocks.count + 1
  end

  # check if block of rooms has availability
  def block_of_rooms_available?(block_id)
    selected_block = @room_blocks.find { |block| block.id == block_id}

  end

  # # reserve a room from within a block of rooms
  # def reserve_within_block(block_id)
  # end
end
