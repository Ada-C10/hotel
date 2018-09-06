class Reservation
  attr_reader :rooms, :start_time, :end_time, :price
  #need to write a test for these

  def initialize(attributes) #attributes is a hash , so theoretically from CSV it would be converted into a hash
    @rooms = []  #the value of room_num could be an array later for rooms
    @start_time = attributes[:start_time]
    @end_time = attributes[:end_time]
    @price = attributes[:price]
  end
end

# 1. get the total cost for a given reservation
#     def total_cost


#when a reservation is made a room number needs to be assigned

#create a cost method
#def total_cost
# end
