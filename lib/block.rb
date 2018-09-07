require_relative 'hotel_helper'

# class Block
module Hotel
  class Block
    attr_reader :group_name, :check_in, :check_out, :room_list, :room_rate

    def initialize(group_name, check_in, check_out, room_list, room_rate)
      @group_name = group_name
      @check_in = Date.parse(check_in)
      @check_out = Date.parse(check_out)
      @room_list = room_list
      @room_rate = room_rate
    end
  end
  # As an administrator, I can create a block of rooms
    # To create a block you need a date range, collection of rooms and a discounted room rate
    # The collection of rooms should only include rooms that are available for the given date range (can find this using calendar)
    # If a room is set aside in a block, it is not available for reservation by the general public, nor can it be included in another block, room_in_block? (number, check_in, checj_out)
  # As an administrator, I can check whether a given block has any rooms available (using Block ID - grouped together) - create new date -> status for that date range
  # As an administrator, I can reserve a room from within a block of rooms (use group name)

  # def my_hotel.create_a_block(group_name, check_in: Date.today, check_out: Date.today + 2, room_rate: 150)
  #  1) Find a list of available rooms: list = Calendar.available_rooms(rooms, check_in, check_out) -> room numbers
  #  2) Check to see if any of these rooms are currently in a block: new_list = Calendar.not_in_block(list, check_in, check_out) -> room list of those not in a block
  #  3) Limit it to 5 rooms: new list (keep first 5)
  #  alice_party = Block.new(group_name, room_list, check_in, check_out, room_rate)
  #  add block to @blocks in hotel manager
  # When a room is reserved from a block of rooms, the reservation dates will always match the date range of the block
  #
  #
  # reserve a room -> create a reservation (group_name)

  # How can I tell if a room is in a block or not?
  # everytime a reservation is made, add it to the calendar, Calendar of each day -> add to calendar? instead of keep in room?
  # add_to_calendar(date_array, room number, block: t/f, rate: 200) -> for each date, add the rooms to an array "date" => {room number: 5, block: true, rate: 150}


  #in block class
  #in_block?(blocks, room_id, check_in, check_out) true/false
    # Search through calendar, look at each date, select room numnber == 5 and block == true
  # if it is in a block, pass in the rate to reservation


end
