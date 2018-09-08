class Reservation
  attr_reader :room_num, :start_time, :end_time, :price
  #need to write a test for these

  def initialize(attributes) #attributes is a hash , so theoretically from CSV it would be converted into a hash
    @room_num = attributes[:room_num]  #the value of room should be an Integer
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
