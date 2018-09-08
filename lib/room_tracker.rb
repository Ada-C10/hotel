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

  attr_reader :valid_reservation, :room, :reservations

  def initialize(valid_reservation , room, reservations)
    @valid_reservation = {}
    @valid_reservation[:room] = @@request_array
    #@valid_reservation[:booking] = @@request_array
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
