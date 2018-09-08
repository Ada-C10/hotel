#Room Class
#The physical space also has nightly rate

require 'pry'
require 'awesome_print'

class Room

@@all_rooms = []
  attr_reader :id

  attr_accessor :cost

def self.all_rooms
  return @@all_rooms
end



  def initialize(id, cost = 200 )
    @id = id
    @cost = cost
    @@all_rooms << self
  end


  def self.rooms
    @@all_rooms = []

    room_id = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20]
    i = 0
    room_id.map do |num| num
      id = num
      cost = 200
      i +=1
      rooms = Room.new(id,cost)
      @@all_rooms << rooms
    end
  end


end



# class HotelMngr
#   @room
#
# def book_room(start,end)
#   @room.is_available(start:today)
# end
# end
#
# class Room
#   def.is_available?(start: start_date, end: end_date)
#   end
#new_room = Room.new(1, 200)
#ap new_room
#write method to list rooms
#ap self.all
#concerned with the physical space
# def self.all
#   CSV.open('./data/customers.csv').map do |customer|
#     id =  customer[0].to_i
#     email = customer[1]
#     address = {street: customer[2], city: customer[3], state: customer[4], zip: customer[5]}
#
#     Customer.new(id,email, address)
#   end
# end
# end
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
