class BlockReservation
  def initialize(number of rooms, start_time, end_time, rate)
    number of rooms  = integer
    rate =  integer
    start_time - Time object
    end_time - Time object

    id = integer - how will this be generated
    block_reservations = [{}]
    rooms - [array of room intance to accomate blocks]
    cost - integer
    #client -hash of client details
  end


  # def make_block_reservation(start_time, end_time)
  #   find room with stauts == avaible
  #   reservarions_list << BlockReservation.new(reservation_data)
  # end

  def self.all

    block_reservations << all
    returns list of all block reservations
  end

  def list_block_reservations_by_date(date)
    check block_reservations for reservation with start_time == date
  end


  def reservation_cost
     cost == difference in days between end_time start_time * rate
  end


end

block_reservation_data = {
  number_of_rooms: 1,
  rate: 150.00,
  start_time: 03-23-2019,
  end_time: 03-26-2019,
  rooms: room,
  cost: 0
}

BlockRevservation.new(block_reservation_data)
