# #Reservation
# A ticket stub with reservation details
#check-in, check-out
#As an administrator, I can reserve a room for a given date range
require 'pry'
require 'date'
require 'awesome_print'
require_relative 'room'

class Reservation

#@@request_array
  attr_writer :start_date, :end_date, :request_array



  def initialize(start_date, end_date,request_array )
    @start_date = start_date
    @end_date = end_date
    @request_array = request_array


  end

  def self.new_booking(start_date, end_date)
    @request_array = []
    new_request =
    Reservation.new(@start_date, @end_date, @request_array)
    @request_array<< new_request
    return @request_array
  end

end
#Reservation.new_booking(start_date:'2012-02-01', end_date:'2012-02-03')
ap Reservation.new_booking('2012-02-01',  '2012-02-03')
#binding.pry
#ap @@request_array
