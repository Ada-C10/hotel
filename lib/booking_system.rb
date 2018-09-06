require 'pry'
require_relative 'room'
require_relative 'reservation'

class BookingSystem

  attr_reader :hotel_instances

  def initialize (start_time, end_time, room)
    @start_time = start_time
    @end_time = end_time
    @room = room

    reserve_room

    @hotel_instances = list_hotel
    @reservation_list = []
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
end
