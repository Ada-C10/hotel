class Reservation
  attr_reader :room_num, :checkin_time, :checkout_time, :price, :customer
  #need to write a test for these

  def initialize(attributes = {})
    @room_num = attributes[:room_num]
    @checkin_time = attributes[:checkin_time]
    @checkout_time = attributes[:checkout_time]
    @price = attributes[:price]
    @customer = attributes[:customer]
  end
end

#when a reservation is made a room number needs to be assigned

#create a cost method
#def total_cost
# end
