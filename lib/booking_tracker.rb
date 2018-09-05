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
    id = @all_reservations == nil ? 1 : @all_reservations.length + 1
    begin_date = date_format(begin_date)
    end_date = date_format(end_date)
    reservation = Reservation.new(id, begin_date, end_date, @cost)
    @all_reservations << reservation
    return reservation
  end

  def reservation_list_by_date(date)
    date = date_format(date)
    reservation_list_by_date = @all_reservations.find_all { |reservation| date >= reservation.begin_date && date <= reservation.end_date }
    return reservation_list_by_date
  end

  def date_format(date)
    return Date.strptime(date, '%m-%d-%Y')
  end
end
