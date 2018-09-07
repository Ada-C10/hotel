require 'pry'
require_relative 'room'
require_relative 'reservation'

module Hotel



  class Hotel
    attr_reader :rooms, :reservations

    PRICE = 200.00

    #invokes all_rooms method and stores that value of in ALL_ROOMS varaible

    def initialize
      @rooms = []
      (1..20).each do |num|
        room = Room.new(num)
        @rooms << room
      end

      @reservations = []
    end

    #returns an array of numbers from a collection of room instances (room_num)
    def get_all_numbers
      room_nums = []
      @rooms.each do |room|
        room_nums << room.room_num
      end
      return room_nums
    end

    #assings random room from the available room's array
    def get_available_room(start_date, end_date)
      # TODO: wave 2, add some logic to figure out which rooms are available
      room_numbers = get_all_numbers
      return room_numbers.first
    end

    #assigns a reservation given a vaild date, and also calls the get_available_room method which will then return a room number

    def assigns_a_reservation(start_date, end_date)
      room_num = get_available_room(start_date, end_date)
      reservation = Reservation.new(start_date, end_date, room_num)
      return reservation
    end
    
  end
end






























#___________________________________________________________________________

# def initialize (start_time, end_time, room)
#   @start_time = start_time
#   @end_time = end_time
#   @room = room
#
#   reserve_room
#
#   @hotel_instances = list_hotel
#   @reservation_list = []
# end
#
# def list_hotel
#   hotel_rooms_array = []
#   hotel_rooms = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20]
#   hotel_rooms.each do |room_num|
#     instance = Room.new(room_num)
#     hotel_rooms_array << instance
#   end
#   return hotel_rooms_array
# end
#
# #list of reservations once they have been made
# def list_reservations
#
# end

# method to actually reserve a room
# def reserve_room
#   one_reservation_request = Reservation.new(@start_time, @end_time, @room).Room.new(@room).availability(@start_time, @end_time)
#   if one_reservation_request == ":available"
#     @reservation_list << one_reservation_request
#   else
#     return "sorry the room is not available for this time"
#   end
#   return @reservation_list
#
# end
# end
