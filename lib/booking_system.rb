require 'pry'
require_relative 'room'
require_relative 'reservation'

class BookingSystem

  attr_reader :hotel_instances

  def initialize (start_time, end_time, room)
    @start_time = start_time
    @end_time = end_time
    @room = room

    @hotel_instances = list_hotel
    @reservation_list = list_reservations

  end

  def list_hotel
    hotel_rooms_array = []
    hotel_rooms = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20]
    hotel_rooms.each do |room_num|
      instance = Room.new(room_num)
      hotel_rooms_array << instance
    end
    return hotel_rooms_array
  end

  #list of reservations once they have been made
  def list_reservations

  end

#method to actually reserve a room
  def reserve_room
  end


end
