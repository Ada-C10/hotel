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
    @valid_reservation = {}
    @valid_reservation[:room] = @@request_array
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

  def make_reservation(start_date, end_date)
    room = @rooms[rand(@rooms.length)] #getavilable room method
    @bookings << Reservation.new(start_date, end_date, room)
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


binding.pry
def assign_request_array_to_hash
  @valid_reservation = {}
@@request_array.each do |booking|

values = @valid_reservation[:room]
values.zip(request_array).to_h
  return values
end
end
#ap @valid_reservation
# users = User.all.each_with_object({}) do |user, hash|
#   hash[user.id] = user
# end
#
# x = {}
# (1..10000).each do |i|
#   x["key#{i}"] = i
# end

#binding.pry
  # def add_room_to_hash
  #   Room.rooms.leangth times do |room|
  #     room = @room[:room]
  #   end
  # end


  end
