require 'date'
require 'pry'

class ReservationMaker

  #input is start and end date
  #output if, if a room is available, sends start, end, and room# to reservation to make an instance of reservation.

  attr_reader :start_date, :end_date, :reservation
  attr_accessor :available_room

  @@reservations = []

  def initialize (start_date, end_date)
    #warning: parentheses after method name is interpreted as an argument list, not a decomposed argument???
    @start_date = start_date
    @end_date = end_date
    @available_room = available_room
    @reservation = reservation
  end

  def available_room
    #find available room by comparing to list of @@reservations
    #generate available room_num
    @available_room = 13
    return @available_room
  end

  def self.reservations
    @@reservations
  end

  def create_reservation
    reservation = Reservation.new(@start_date, @end_date, @available_room)
    @reservation =
      {
        start_date: reservation.start_date,
        end_date: reservation.end_date,
        available_room: reservation.available_room,
        duration: reservation.reservation_duration,
        cost: reservation.cost
      }
    @@reservations << @reservation
    binding.pry
    return @@reservations
  end

end

start_date1 = Date.new(2018,2,3)
end_date1 = Date.new(2018,2,5)
@available_room = 13

start_date2 = Date.new(2018,3,1)
end_date2 = Date.new(2018,3,2)
@available_room = 20

example1 = ReservationMaker.new(start_date1, end_date1)
example2 = ReservationMaker.new(start_date2, end_date2)

puts example1.create_reservation
puts example2.create_reservation
