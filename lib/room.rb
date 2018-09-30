require_relative 'reservation'

module Hotel
  class Room
    attr_reader :room_number
    attr_accessor :status

     def initialize(room_number, status = :Available)
      @room_number = room_number
      @status = status
    end
    def self.create_rooms
      @all_rooms = [ ]
      room_number = 0
      20.times do
        room_number += 1
        @all_rooms << Room.new(room_number)
      end
      return @all_rooms
    end
     def self.list_all_rooms
      @all_rooms = self.create_rooms
      return @all_rooms
    end
  end
end
# module Hotel
#   # create new class of Room, to create the block of rooms
#   class Room
#     attr_accessor :rooms, :room_cost, :reservations
#
#
#     def initialize
#       @rooms = rooms
#       @room_cost = 200
#       @reservations = []
#       @blocks = []
#     end
#
#     def create_rooms
#       20.times do
#         @all_rooms << Room.new
#       end
#       puts @all_rooms
#     end
#
#     def room_list
#       return @all_rooms
#     end
#   end
# end
