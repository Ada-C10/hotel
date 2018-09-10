class Reservation
  attr_reader :check_in, :check_out, :cost
  # attr_accessor
  def initialize(check_in, check_out, room)
    @check_in = check_in
    @check_out = check_out
    @cost = reservation_cost
    @room = room # turn to array of room object for block ?

    raise ArgumentError if check_in >= check_out

    # @block_reservation = block_reservation
    # @id = integer
    # @client = client # hash of client details
  end


  def nights
    nights = check_out - check_in
    return nights
  end

  def reservation_cost
    cost = nights * 200
    return cost
  end

 # def range 
 #   return (check_in..check_out)
 # end

  # def make_block_reservation(number of rooms, start_time, end_time, rate)
  #   raise error of number of rooms > 5
  #   assign 1 - 5 availble rooms to reservation
  #   cost = calculates discouted cost
  # end


end


# block_reservation_data_ = {
#   id: 1,
#   start_time: 03-23-2019,
#   end_time: 03-26-2019,
#   rooms: [{room}, {room}, {room}],
#   cost: 0
# }
