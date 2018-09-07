require 'pry'
require_relative 'room'
require_relative 'reservation'

module Hotel

  PRICE = 200.00

  #invokes all_rooms method and stores that value of in ALL_ROOMS varaible

  ALL_ROOMS = []

  #returns an array of all rooms that have been instanced by room class (Dan, warp in method and pass)
    (1..20).each do |num|
      room = Hotel::Room.new(num)
      ALL_ROOMS << room
    end


  #returns an array of numbers from a collection of room instances (room_num)
  def self.get_all_numbers(rooms)
    room_nums = []
    rooms.each do |room|
      room_nums << room.room_num
    end
    return room_nums
  end

  #returns an all rooms object with numbers  which is stored in an array ex: [#<Hotel::Room:0x00007fa58725a268 @room_num=1>
  def self.get_rooms
    return ALL_ROOMS
  end

  #returns a boolean--check to see if I will make an instance of a reservation

  #assings random room from the available room's array
  def self.assign_rand_available_room
    rand_room = get_all_numbers(ALL_ROOMS)
    return rand_room.sample.to_i
  end

  # return boolean if vaild date is right (true if right) false if not
  def valid_dates? (start_date, end_date)
    return start_date < end_date
  end

  # def assigns_a_reservation(start_date, end_date)
  #   rand_avil_room = assign_rand_available_room
  #   reservation = Reservation.new(start_date, end_date, rand_avil_room)
  # end






  # p Hotel.assign_rand_available_room

  # puts "all hotel ALL_ROOMS "
  # y =  Hotel.get_rooms
  # puts y

  # puts "______________________________________________________________________"
  #   # gets an array of room numbers only (pulls them out of array instances)
  # puts "XXXXXXX"
  # x =  Hotel.get_all_numbers(ALL_ROOMS)
  # p x

  # z = Hotel.assign_available_room

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
