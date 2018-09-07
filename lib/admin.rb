require 'pry'
require 'date'
require_relative 'reservation'
require_relative 'room'

class Admin
  attr_reader :reservations, :rooms

  def initialize
    @rooms = []
    @reservations = []
    20.times do |i|
      room_new = Room.new(i+1)
      @rooms << room_new
      booked_dates = []
      {room_id: i+1, booked_dates: booked_dates }
    end
  end

  # def list_reservations(date_selected)
  #
  # end

  # def make_reservation(start_date, end_date)
  #   # reservations array should have a room hash inside it
  #   # room: Room, dates_booked: []
  #
  #   # change the start_date and end_date to an array by calling a help method, return  a dates_required array
  #
  #   # loop through the existing reservation array, by room, compare the booked dates array under each room with the dates_required
  #
  #   # if we found the dates_required do not have a date in common with the dates booked, return the that room, create a new reservation item, and add it to the reservation array .
  #
  #   if start_date.class != Date || end_date.class != Date
  #     raise ArgumentError, "start_date and end_Date should be Date objects"
  #   end
  #   if start_date >= end_date || start_date < Date.today
  #     raise ArgumentError, "invlid dates entered"
  #   end
  #
  # end
  #
  # def cost_of_reservation(reservation_id)
  #   return find_reservation(reservation_id).cost
  # end

  # def find_room(id)
  #   check_id(id)
  #   return @rooms.find { |room| room.room_num == id }
  # end
  #
  # def calculate_cost
  #
  # end
  #

  #   def check_id(id)
  #     raise ArgumentError, "ID cannot be blank or less than zero. (got #{id})" if id.nil? || id <= 0
  #   end
  #

end
