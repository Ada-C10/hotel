require_relative 'room'
require_relative 'reservation'


require 'date'
require 'pry'

class FrontDesk
  attr_reader :reservations, :rooms

  def initialize
    @rooms = load_rooms
    @reservations = []

  end

  def load_rooms
    rooms = []
    20.times do |i|
      rooms << Room.new((i + 1))
    end
    return rooms
  end

  def list_all_rooms
    rooms.each do |room|
      room
    end
  end

  def create_reservation(room_number, start_day, end_day)
    new_reservation = Reservation.new(room_number, start_day, end_day)
    reservations << new_reservation
    room = find_room(room_number)
    room.add_reservation_to_room(new_reservation)

  end

  def find_room(room_number)
    return @rooms.find {|room| room.room_number == room_number}
  end

  def find_by_date(date)
        @reservations.select {|reservation| reservation.start_day <= date && reservation.end_day >= date}
      end












#
#     def all_the_rooms
#       return @all_rooms
#     end
#
#     def self.all
#       self.create_rooms
#     end
#
#     def make_reservation(room_number, start_day, end_day)
#       room = find_room(room_number)
#       new_reservation = Hotel::Reservation.new(room, start_day, end_day)
#       @reservations << new_reservation
#       add_res_to_room(room, new_reservation)
#       return new_reservation
#     end
#
#     def find_room(room_number)
#       all_the_rooms.find {|room| room.room_number == room_number}
#     end
#
#     def add_res_to_room(room, new_reservation)
#       room.room_reservations << new_reservation
#     end
#
#     def find_by_date(date)
#       @reservations.select {|reservation| reservation.start_day <= date && reservation.end_day >= date}
#     end
#
#   end
#
# end
end
