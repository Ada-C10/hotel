require 'date'
require 'pry'

class ReservationMaker

  #input is start and end date
  #output if, if a room is available, sends start, end, and room# to reservation to make an instance of reservation.

  attr_reader :start_date, :end_date, :room_num

  @@reservations = []

  def initialize (start_date, end_date)
    @start_date = start_date
    @end_date = end_date
    @room_num = room_num
  end

  def find_available_room
    #find available room by comparing to list of @@reservations
    return @room_num
  end

  def self.reservations
    @@reservations
  end

  def create_reservation
    reservation = Reservation.new(@start_date, @end_date, @room_num)
    @@reservations << reservation
    return @@reservations
  end

  # Make new incidence of ReservationMaker each time a new request for a reservation is made?
  #how compose a new reservation?  What type of data will it come in as?

end

# @start_date = Date.new(2018,2,3)
# @end_date = Date.new(2018,2,5)
# @room_num = 13
#
# example = ReservationMaker.new(@start_date, @end_date)
# puts example.reservations
