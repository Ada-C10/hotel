class Reservation
  attr_reader :rooms, :checkin_time, :checkout_time, :price,
  #need to write a test for these

  def initialize(attributes) #attributes is a hash , so theoretically from CSV it would be converted into a hash
    @rooms = []  #the value of room_num could be an array later for rooms
    @checkin_time = attributes[:checkin_time]
    @checkout_time = attributes[:checkout_time]
    @price = attributes[:price]
  end
end
reservation = Reservation.new
(date_range: {checkin_time: Date.new, checkout_time: Date.new -1}, room: room)  # <----room object contains {room_num:, price: STANDARD_ROOM_PRICE, customer: ""}
#
# 1. get the total cost for a given reservation
#     def total_cost


#when a reservation is made a room number needs to be assigned

#create a cost method
#def total_cost
# end
