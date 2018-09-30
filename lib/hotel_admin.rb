# require_relative 'room.rb'
# require_relative 'reservation.rb'
#
#
# module Hotel
#   class Admin
#     attr_accessor :rooms
#     def initialize
#       @rooms = Hotel::Room.create_rooms
#     end
#
#
#   def new_reservation(room_number, start_date_time, end_date_time, cost)
#     @room_number = room_number
#     @start_date_time = start_date_time
#     @end_date_time = end_date_time
#     @cost = cost
#   end
#   @new_reservation
#
#     def check_room_status
#       @booked_rooms = []
#       @open_rooms = []
#       @rooms.each do |number, status|
#         if :room_status == :Available
#           status = :Unavailable
#           @booked_rooms << room
#         elsif :room_status == :Available
#           @open_rooms << room
#         end
#         @booked_rooms
#         @open_rooms
#       end
#     end
#   end
#
#   end
# end
