require 'pry'
require 'date'
require_relative 'reservation'
require_relative 'room'

class Admin
  attr_reader :reservations, :rooms, :room_unbooked_dates

  def initialize
    @rooms = []
    @reservations = []
    @room_unbooked_dates = []

    20.times do |i|
      room_new = Room.new(i+1)
      @rooms << room_new
      365.times do |i|
        date_new = Date.today + i
        @room_unbooked_dates << {room_n: room_new, unbooked_date: date_new}
      end
    end
  end

  def find_room_available(start_date, end_date)


  end


  def make_reservation(reservation_id, customer_name,room_id, start_date, end_date)

    # loop through the existing reservation array, by room, compare the booked dates array under each room with the dates_required

    # if we found the dates_required do not have a date in common with the dates booked, return the that room, create a new reservation item, and add it to the reservation array .

    # call the add_reserve_dates method under that room, and add it to room

    if start_date.class != Date || end_date.class != Date
      raise ArgumentError, "start_date and end_Date should be Date objects"
    end
    if start_date >= end_date || start_date < Date.today || end_date > (Date.today + 365)
      raise ArgumentError, "invlid dates entered"
    end

    room = find_room(room_id)

    result = Reservation.new(reservation_id, customer_name, room, start_date, end_date)

    @reservations << result

    start_d = start_date

    while start_d < end_date
      @room_unbooked_dates.reject! {|item| item == {room_n: room, unbooked_date: start_d}}
      start_d += 1
    end

    return result

  end


  # input a string of date, to return the list of the reservations on that date
  def list_reservations(date_selected)
    return @reservations.select {|reserve| reserve.dates_booked.include? date_selected}

  end


  def find_room(id)
    raise ArgumentError, "ID cannot be blank, less than zero or more than 20. (got #{id})" if id.nil? || id <= 0 || id > 20
    return @rooms.find { |room| room.room_num == id }
  end

  def find_reservation(id)
    raise ArgumentError, "ID cannot be blank or less than zero. (got #{id})" if id.nil? || id <= 0
    return @reservations.find {|reserve| reserve.id == id }

  end

  def calculate_cost(reservation_id)

    return find_reservation(reservation_id).reserve_cost

  end

end
