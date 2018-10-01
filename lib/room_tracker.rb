#Room Tracker
# As an administrator, I can access the list of all of the rooms in the hotel
# As an administrator, I can access the list of reservations for a specific date
# As an administrator, I can get the total cost for a given reservation

# The person who manages the reservation book (Takes new reservations and checks availability)
#
# List all rooms
# Keep track room availability
# Keep track of available dates - dates are in ranges
# Put requested dates into a date array
#calculate number of nights = reservation end date - 1 unless only 1 night stayed
#Room tracker keeps track of rooms and thier associated reservations.
#Rooms are the key and new_bookings are the associated value.
#new_bookings are an array - to find available rooms check each room and search the booking date ranges.
#if date range is free then new room becomes room x
#calculate total cost here
#calculate list of reservations
#creates the objects depends on room and reservation. They don't depend on it.
require 'pry'
require 'awesome_print'
require_relative 'reservation'
require_relative 'room'

class Room_Tracker

  def initialize
    # @valid_reservation = {}
    # @valid_reservation[:room] = @@request_array
    @rooms = get_rooms(20)
    @bookings = []
    #@valid_reservation[:booking] = @@request_array
  end

  def get_rooms(room_count)
    rooms = []
    room_count.times do |index|
      id = index + 1
      cost = 200
      rooms << Room.new(id,cost)
    end
    return rooms
  end

  def list_all_rooms
    return @rooms
  end

#As an administrator, I can reserve an available room for a given date range
  def make_reservation(start_date, end_date)
      occupied_rooms = []
      if date_overlap_check(start_date, end_date) == false
        room = @rooms.first
        occupied_rooms << room
        @bookings << Reservation.new(start_date, end_date, room)
      else
        counter = 0
          while counter <= @rooms.length
            @rooms.each_with_index do |room, i|
              @bookings.each do |booking|
              if room[i] == booking.room
                i + = 1
              else
                room[i] = room[i]
                occupied_rooms <<room
                end
              end
                end
            end
          end
        end


  def find_reservations_by_date(date)
    bookings = []
    @bookings.each do |booking|
      range = booking.start_date..booking.end_date
      if range.cover?(date)
        bookings << booking
      end
    end
    return bookings
  end

  def reservation_total_cost(reservation)
    return reservation.total_cost
  end

end
