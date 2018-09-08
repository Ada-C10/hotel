require_relative 'hotel_helper'

# class Block
module Hotel
  class Block
    attr_reader :group_name, :start_date, :end_date, :room_rate
    attr_accessor :room_list

    def initialize(group_name, room_list, start_date: Date.today, end_date: Date.today + 2, room_rate: 175)
      @group_name = group_name
      @start_date = start_date
      @end_date = end_date
      @room_list = Block.create_list_with_availability(room_list)
      @room_rate = room_rate
    end

    def self.all_available_rooms_in_block(blocks, group_name)
      block = Block.find_block(blocks, group_name)
      list = block.room_list.select{|k, v| v == :AVAILABLE}.keys

      list = nil if list.empty?
      return list
    end

    def self.find_block(blocks, group_name)
      return blocks.find {|b| b.group_name == group_name}
    end

    private
    def self.create_list_with_availability(room_list)
      formatted_list = {}
      room_list.each do |room_number|
        formatted_list[room_number] = :AVAILABLE
      end
      return formatted_list
    end
  end

  # As an administrator, I can reserve a room from within a block of rooms (use group name)
  # When a room is reserved from a block of rooms, the reservation dates will always match the date range of the block
  # reserve a room -> create a reservation (group_name)
  # if it is in a block, pass in the rate to reservation
end
