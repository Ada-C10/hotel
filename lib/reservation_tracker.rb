module Hotel
class ReservationTracker

  attr_reader :reservations

  def initialize
    @reservations = []
  end

  def add_reservation(reservation)

    unless reservation.class == Hotel::Reservation
      raise ArgumentError, "Please input a valid reservation"
    end
    @reservations << reservation
  end

  def sortby_startdate
    @reservations.sort_by!{ |reservation| reservation.start_date }
  end

  def list_rooms
    return [*1..20]
  end

  def select_room
    return 1
  end

  def reservations_during_date(date)

    valid_reservations = @reservations.find_all do |reservation|
      reservation.date_within_reservation?(date)
    end

    return valid_reservations.empty? ? nil : valid_reservations
  end

  def available_rooms(start_date, end_date)

    unavailable_rooms = []

    @reservations.each do |reservation|
      if reservation.daterange_within_reservation?(start_date, end_date)
        unavailable_rooms << reservation.room
      end
    end

    return ([*1..20] - unavailable_rooms)
  end

  def book_reservation(room, start_date, end_date)

    unless start_date.is_a?(Date) && end_date.is_a?(Date)
      raise ArgumentError, "Invalid date format"
    end

    unless available_rooms(start_date, end_date).include?(room)
      raise StandardError, "Room is not available for these dates."
    end

    reservation = Hotel::Reservation.new(room, start_date, end_date)
    @reservations << reservation
    return reservation
  end
end
end
