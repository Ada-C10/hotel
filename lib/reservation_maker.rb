require 'date'
require 'pry'

class ReservationMaker

  #input is start and end date
  #output if, if a room is available, sends start, end, and room# to reservation to make an instance of reservation.

  attr_reader :start_date, :end_date, :room_num, :reservation

  @@reservations = []

  def initialize (start_date, end_date)
    @start_date = start_date
    @end_date = end_date
    @room_num = room_num
    @reservation = reservation
  end

  # def find_available_room
  #   #find available room by comparing to list of @@reservations
  #   return @room_num
  # end

  def self.reservations
    @@reservations
  end

  def create_reservation
    @reservation = Reservation.new(@start_date, @end_date, @room_num)
    binding.pry
    @@reservations << @reservation
    return @@reservations
  end

end

start_date = Date.new(2018,2,3)
end_date = Date.new(2018,2,5)
@room_num = 13

example = ReservationMaker.new(start_date, end_date)

puts example.start_date
puts example.create_reservation
