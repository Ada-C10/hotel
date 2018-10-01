require 'pry'
require 'date'
require_relative 'room'
require_relative 'block'
require_relative 'reservation'
# Keeps track of the list of reservations
# module Hotel
class ReservationTracker
  attr_reader :rooms, :check_in_date, :check_out_date, :reservations, :unreserved_rooms, :blocks

  def initialize
    @rooms = create_rooms
    @reservations = []
    @unreserved_rooms = []
    @blocks = []
    # @existing_reservations = []


  end

  # creates and accesses the list of all of the rooms in the hotel
  def create_rooms
    rooms = []
    (1..20).each do |room|
      room_number = Room.new(room)
      rooms << room_number
    end
    return rooms
  end

  # creates reservation and adds the reservation to the list of reservations
  def create_reservation(check_in_date, check_out_date, room_number)
    reservation = Reservation.new(check_in_date, check_out_date, room_number)
    @reservations << reservation
    # @reserved_rooms << room
    # return reservation
  end

  def create_a_block(check_in_date, check_out_date, block_of_rooms)
    # rooms_available is an arrary from rooms_not_reserved
    rooms_available = rooms_not_reserved(check_in_date,
                                        check_out_date)
    block_reservation = Block.new(check_in_date,
                      check_out_date,
                      block_of_rooms)
    block_reservation.rooms = rooms_available.pop(block_of_rooms)
    @blocks << block_reservation

    return block_reservation
  end

  # don't think i need this anymore
  # def is_a_room_available?(date)
  #   @reservations.each do |reservation |
  #     return false if reservation.check_in_date >= date && reservation.check_out_date > date
  #   end
  #   # binding.pry
  #   return true
  # end

  # accesses the list of reservations for a specific date
  def list_of_reservations(date)
    return @reservations.find_all { |reservation| reservation.nights_stayed == date }
  end

  # calculates the total cost for a given reservation
  def cost_for_given_reservation(reservation)
    total_cost = reservation.nights_stayed * Room::ROOM_RATE
    return total_cost
  end

  # checks to see if a room is available and reserves the first available room for a given date range. Uses the rooms_not reserved method.
  def reserve_room(check_in_date, check_out_date)
     # set the rooms_not_reserved method and arguments to a local variable.
     unreserved_rooms = rooms_not_reserved(check_in_date, check_out_date)
     if unreserved_rooms.length == 0
      raise ArgumentError, 'No Available Rooms for Given Dates'
    else
      # uses the create reservation method if there are available rooms
      create_reservation(check_in_date, check_out_date, unreserved_rooms[0])
      # binding.pry
    end
  end

  # accesses a list of rooms that are not reserved for a given date range
  def rooms_not_reserved(check_in_date, check_out_date)
    # if the reservations array is empty, this returns an array of available room numbers. If there are no reservations, all rooms can be reserved.
    return @rooms.map { |room| room.room_number } if @reservations.empty?
    unreserved_rooms = @rooms.map { |room| room.room_number }
    # if @reservation.empty? is not empty
    @reservations.each { |reservation|
      if (reservation.check_in_date >= check_in_date && reservation.check_in_date <= check_out_date) || (reservation.check_out_date >= check_in_date && reservation.check_out_date <= check_out_date)
        unreserved_rooms.delete(reservation.room_number)
      end
    }

    @blocks.each { |block|
        if (block.check_in_date >= check_in_date &&  block.check_in_date <= check_out_date) || (block.check_out_date >= check_in_date && block.check_out_date <= check_out_date)
          unreserved_rooms - block.rooms
        end
      }
    # unreserved_rooms returns an empty array if  nothing is availible in the given date range or it will return an array of available room numbers in date range given.
    # for use in the reserve_room method
    return unreserved_rooms
  end

end
# end
