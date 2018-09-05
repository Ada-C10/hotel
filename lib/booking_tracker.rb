require 'date'
require 'pry'
require_relative 'reservation'

class BookingTracker
  attr_reader :rooms, :all_reservations, :cost

  def initialize
    @rooms = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]
    @all_reservations = []
    @cost = 200
  end

  def new_reservation(begin_date, end_date)
    begin_date = date_format(begin_date)
    end_date = date_format(end_date)

    raise ArgumentError, "Invalid dates. Begin date must be at least one day prior to end date." if begin_date > end_date

    room_num = find_available_room(begin_date, end_date)

    reservation = Reservation.new(begin_date, end_date, room_num, @cost)
    @all_reservations << reservation
    return reservation
  end


  def reservation_list_by_date(date)
    date = date_format(date)

    reservation_list_by_date = @all_reservations.find_all { |reservation| date >= reservation.begin_date && date <= reservation.end_date }
    return reservation_list_by_date
  end


  def find_available_room(begin_date, end_date)
    beg_dt = date_format(begin_date)
    end_dt = date_format(end_date)
    return open_rooms(beg_dt, end_dt).first
  end


  def open_rooms(begin_date, end_date)
    available_rooms = []
    used_rooms = []
    beg_dt = date_format(begin_date)
    end_dt = date_format(end_date)

    (beg_dt..end_dt).each do |date|
      reservation_list_by_date(date).each do |reservation|
        used_rooms << reservation.room_num
      end
    end

    used_rooms.uniq!
    available_rooms = @rooms - used_rooms
    return available_rooms
  end


  def date_format(date)
    if date.class == Date
      return date
    else
      return Date.strptime(date, '%m-%d-%Y')
    end
  end

end
