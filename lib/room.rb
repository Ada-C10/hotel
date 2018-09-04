class Room
  attr_reader :room_num, :price, :availability

  def initialize(input)
    @room_num = input[:room_num]
    @price = input[:price]
    @availability = input[:availability]
  end
end


# it "creates a new instance of Reservation" do
#   expect(@room.reserve(checkin_time: Date.new(2018,8,1), checkout_time: Date.new(2018,8,25))).must_be_kind_of Reservation
# end
