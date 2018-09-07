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
  # def add_reservation(room_number, reservation)
  #   # reservation.get_all_dates.each do |date|
  #   dates = reservation.get_all_dates
  #   @room_assignments[room_number].empty?
  #   dates.each do |date|
  #     @room_assignments[room_number] << date
  #   end
  #   return "Added!"
  # end

  def available_room?(room_number, reservation)
    dates = reservation.get_all_dates
    dates.each do |date|
      unless @room_assignments[room_number].include? (date)
        return true
      end
      return false
    end

  end
  def list_available_rooms(reservation)
    available_rooms = []
    ROOMS.each do |room|
      available_rooms << room if available_room?(room, reservation)
    end
    return available_rooms
  end

  def add_reservation(reservation)
    # reservation.get_all_dates.each do |date|
    list = list_available_rooms(reservation)
    room = list.first
    dates = reservation.get_all_dates
    dates.each do |date|
      @room_assignments[room] << date
    end
    return "Added!"
  end
end
