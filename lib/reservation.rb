class Reservation
  attr_reader :room_num, :checkin_time, :checkout_time, :price, :customer
  #need to write a test for these

  def initialize(input)
    @room_num = input[:room_num]
    @checkin_time = input[:checkin_time]
    @checkout_time = input[:checkout_time]
    @price = input[:price]
    @customer = input[:customer]
  end
end
