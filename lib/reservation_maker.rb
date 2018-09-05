require 'date'
require 'pry'

class ReservationMaker

  attr_reader :start_date, :end_date

  @@reservations = []

  def initialize (start_date, end_date)
    @start_date = start_date
    @end_date = end_date

    if @end_date < @start_date
      raise ArgumentError.new ("The start date cannot be after the end date.")
    end
  end

  def rooms
    rooms = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]
    return rooms
  end

  def available_room
    #find available room by comparing to list of @@reservations
    #generate random assignment of available room_nums

    # @@reservations.each do |reservation|
    #   if @available_room != reservation[:available_room]
    #     @available_room = rand(20)
    #   end
    return rooms.sample
  end

  def self.reservations
    @@reservations
  end

  def create_reservation
    reservation = Reservation.new(@start_date, @end_date, available_room)
    @reservation =
      {
        start_date: reservation.start_date,
        end_date: reservation.end_date,
        room: reservation.room,
        reservation_duration: reservation.reservation_duration,
        cost: reservation.cost
      }
    @@reservations << @reservation
    # binding.pry
    return @@reservations
  end

end


# start_date1 = Date.new(2018,2,3)
# end_date1 = Date.new(2018,2,5)
# @available_room = 13
#
# start_date2 = Date.new(2018,3,1)
# end_date2 = Date.new(2018,3,2)
# @available_room = 20
#
# example1 = ReservationMaker.new(start_date1, end_date1)
# example2 = ReservationMaker.new(start_date2, end_date2)
#
# example1.start_date
#
# puts example1.create_reservation
# puts example2.create_reservation
