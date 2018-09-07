class Reservation
  def initialize(start_time, end_time)
    start_time = Time object
    end_time = Time object

    # id = integer
    room = [{room}]
    cost = integer
    reservarions_list = [{}]
    block_reservations = [{}]
    #client -hash of client details
  end


  def nights
    # difference between checkin and checkout
    # be mindful of checkout, no charge on that day
  end

  def cost
    # cost = nights * 200
  end



  # def make_block_reservation(number of rooms, start_time, end_time, rate)
  #   raise error of number of rooms > 5
  #   assign 1 - 5 availble rooms to reservation
  #   cost = calculates discouted cost
  # end


end

# Reservation.new(checkin, checkout)
#
# reservation_data = {
#   checkin: 03-23-2019,
#   checkout: 03-26-2019,
#
#   # id = integer  generate id?
#   cost = integer # reservation_cost to generate cost
#   room = room object
# }

# block_reservation_data_ = {
#   id: 1,
#   start_time: 03-23-2019,
#   end_time: 03-26-2019,
#   rooms: [{room}, {room}, {room}],
#   cost: 0
#
# }
