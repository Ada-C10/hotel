# #Reservation
# A ticket stub with reservation details
#check-in, check-out
#As an administrator, I can reserve a room for a given date range
require 'pry'
require 'date'
require 'awesome_print'
require_relative 'room'

class Reservation

  @@request_array = []
  attr_writer :start_date, :end_date

  def request_array
    return @@request_array
  end

  def initialize(start_date, end_date)
    @start_date = start_date
    @end_date = end_date
    @@request_array << self
  end

  def self.new_booking(start_date, end_date)
    @@request_array = []
    Reservation.new(start_date, end_date)
  end



end
#Reservation.new_booking(start_date:'2012-02-01', end_date:'2012-02-03')
ap Reservation.new_booking('2012-02-01',  '2012-02-03')
#binding.pry
#ap @@request_array
