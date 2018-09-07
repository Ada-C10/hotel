require 'time'
require_relative 'reservation'
require_relative 'front_desk'
require_relative 'room'

class Block
  def initialize(block_start, block_end, rate, number_of_rooms)
    @block_start = block_start
    @block_end = block_end
    @rate = rate
    @number_of_rooms = number_of_rooms
    @Block_ID = #reference some random number method
    #put standard error checker that makes sure that the number of rooms is not more than 5
end

#In front_desk, create a block! gotta make all these rooms unavailable too.
# Do I make the booker pick all rooms, probably the easier way to go right now, but actually
# it might end up being harder to do....would have to take in user input or something...
#   or do I not even have to think about that??? Like if I just take a array of them, that works
#     logically and someone else can worry about the user interface....
#  And then there is a seperate method for booking a room from
# #a block...this will side step the issues of having to beef up the method for booking a regular room
# # when you book a room from a block, you must have the ID for hte block to continue. Kinda like a
# #password for a presale or something. The next part would be to keep track of how many rooms are booked from
# #the block, so if 5 are blocked and they try to do the 6th, there is not anything left for them and this should raise an error.
#Should go back and fix rooms and their cost calculations before going any futher with this, also
#check ALL the tests, because this will fuck them all up
