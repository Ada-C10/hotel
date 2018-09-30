require_relative 'hotel_helper'

# class Block creates instances of Block
# and can search through blocks for information
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

    def self.all_available_rooms_in_block(blocks, group_name, start_date: Date.today, end_date: Date.today + 2)
      block = Block.find_block(blocks, group_name, start_date: start_date, end_date: end_date)
      list = block.room_list.select{|k, v| v == :AVAILABLE}.keys

      list = nil if list.empty?
      return list
    end

    def self.find_block(blocks, group_name, start_date: Date.today, end_date: Date.today + 2)
      return blocks.find {|b| b.group_name == group_name and b.start_date == start_date and b.end_date == end_date}
    end

    def change_status(room_number)
      @room_list[room_number] = :UNAVAILABLE
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
end
