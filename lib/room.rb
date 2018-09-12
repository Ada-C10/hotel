class Room
  attr_reader :room_number, :dates, :reservations
  attr_accessor :status
  def initialize(room_number, status = :available)
    @room_number = room_number
    @status = status # valid_status = [:available, :reserved, :blocked]
    @reservations = []

    raise ArgumentError if room_number > 20
  end

  def reserve(reservation)
    @reservations << reservation
  end

  def available?(start_date, end_date)
    # status == :available ? true : false
    @reservarions.none? do |reservation|
      reservation.during?(check_in, check_out)
    end
  end

end
