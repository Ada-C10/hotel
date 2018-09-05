#Room Class
require 'pry'

class Room

  attr_reader :id

  attr_accessor :status, :cost

  def initialize(id, cost = 200 )
    @id = id
    @cost = cost
  end
end

#concerned with the physical space

# def room_id_assign
# rooms = [0...19]
# room_number = rooms.each_with_index do |index|
# room_number = room_numbers[i]
# room_number<<room_numbers
# binding.pry
# end
# end



#assign id of room from an array of 0-19
#   def room_id_assign
#     room_a = [0..19]
#     room_a.map do |index|
#       #The index of the array is the room number.
#       room_a = room_a[index]
#       return room_a
#       binding.pry
#     end
#   end
#   #@room_id<<Room.new(room_id,status, cost)
#





# As an administrator, I can access the list of all of the rooms in the hotel
# As an administrator, I can reserve a room for a given date range
# As an administrator, I can access the list of reservations for a specific date
# As an administrator, I can get the total cost for a given reservation
