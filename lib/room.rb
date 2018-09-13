class Room
  attr_reader :room_number, :dates
  attr_accessor :status, :reservations
  def initialize(room_number, status = :available, reservations = [])
    @room_number = room_number
    @status = status # valid_status = [:available, :reserved, :blocked]
    @reservations = reservations

    raise ArgumentError if room_number > 20
  end

  def reserve(reservation)
    @reservations << reservation
  end

  # def available?(check_in, check_out)
  #   @reservarions.none? do |reservation|
  #     reservation.during?(check_in, check_out)
  #   end
  # end

end
