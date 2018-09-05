class Calendar
  attr_reader :room_assignments
  ROOMS = [*1..20]
  def initialize
    # @reservations = []
    @room_assignments = {
      1 => [],
      2 => [],
      3 => [],
      4 => [],
      5 => [],
      6 => [],
      7 => [],
      8 => [],
      9 => [],
      10 => [],
      11 => [],
      12 => [],
      13 => [],
      14 => [],
      15 => [],
      16 => [],
      17 => [],
      18 => [],
      19 => [],
      20 => []
    }
  end
  def add_reservation(reservation)
    # reservation.get_all_dates.each do |date|
    dates = reservation.get_all_dates
    @room_assignments.each do |k, v|
      if v.empty?
        dates.each do |date|
          @room_assignments[k] << date
        end
        return "Added!"
      end
    end
  end
end

# end
