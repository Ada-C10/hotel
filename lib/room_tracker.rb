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
# Room Tracker is a hash with date as key and values are array of reservations associated with the date
# Reservations per date = hash key value
#calculate total cost here
#calculate list of reservations
#creates the objects depends on room and reservation. They don't depend on it.
require 'pry'
require 'awesome_print'
require_relative 'reservation'
require_relative 'room'

class Room_tracker

  attr_reader :valid_reservation

  def initialize(valid_reservation)
@valid_reservation = valid_reservation
end

def new_valid_reservation

new_room = Room.new(1, 200)
Reservation.new_booking('2012-02-01',  '2012-02-03')<<new_room = Room.new(1, 200)
  end



end
#   end
#
#   def rooms_list
#     room_id = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20]
#     i = 0
#     room_id.map do |num| num
#       id = num
#       cost = 200
#       i +=1
#       rooms = Room.new(@id,@cost)
#     end
#     return rooms
#   end
# end
#   def new_reservation(start_date, end_date)
#       start_date = Date.parse('2012-02-01')
#       # end_date = Date.parse('2012-02-03')
#       Reservation.new(start_date,end_date)
#     end
#    ap new_reservation(2012-02-01,2012-02-03 )
# end









  # #ap ooms
  #
  # def available
  #
  #   @valid_reservation = self.new_reservation
  # return @valid_reservation
  # end
  #  ap @valid_reservation
  #
  # end
