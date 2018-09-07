require_relative 'hotel_helper'

# class Block
module Hotel
  class Block
    # attr_reader
    #
    # def initialize(room_number, check_in, check_out)
    #
    # end
  end
  # As an administrator, I can create a block of rooms
    # To create a block you need a date range, collection of rooms and a discounted room rate (fix total cost to have default value)
    # The collection of rooms should only include rooms that are available for the given date range (can find this using calendar)
    # If a room is set aside in a block, it is not available for reservation by the general public, nor can it be included in another block
  # As an administrator, I can check whether a given block has any rooms available (using Block ID - grouped together)
  # As an administrator, I can reserve a room from within a block of rooms
  #
  # A block can contain a maximum of 5 rooms
  # When a room is reserved from a block of rooms, the reservation dates will always match the date range of the block
  # find room_list for date range, see if block == false (if not, delete from array) (take first 5 room id's)
  # alice_party = Block.new(group_name, check_in, check_out, room_list, room_rate)
  # in this method: room changes to private for those days, block changes to true

  # reserve a room -> create a reservation
  # if it is in a block, pass in the rate to reservation

end
