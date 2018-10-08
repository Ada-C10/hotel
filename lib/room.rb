class Room
  # This class seems to mostly serve as a a container for reservations, which might be better served as a feature of your Hotel class.
  attr_reader :room_number, :dates
  attr_accessor :status, :reservations
  def initialize(room_number, status = :available, reservations = [])
    @room_number = room_number
    @status = status # valid_status = [:available, :reserved, :blocked]
    @reservations = reservations
    # rethinking design
    @dates_range = check_in..check_out

    raise ArgumentError if room_number > 20
  end

  def reserve(reservation)
    @reservations << reservation
  end

  def available?(check_in, check_out)
    @reservations.each do |reservation|
      reservation.during?(check_in, check_out)
    end
  end

  def room_availble?(check_in, check_out)
    @date_range.include?(check_out)
  end
end
