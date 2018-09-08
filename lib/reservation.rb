# #Reservation
# A ticket stub with reservation details
#check-in, check-out
#As an administrator, I can reserve a room for a given date range
require 'pry'
require 'date'
require 'awesome_print'
require_relative 'room'

class Reservation

  attr_reader :start_date, :end_date, :room, :total_cost

  def initialize(start_date, end_date, room)
    @start_date = start_date
    @end_date = end_date
    @room = room
    @total_cost = calculate_total_cost(start_date, end_date)
  end

  def calculate_total_cost(start_date, end_date)
    total_cost = 0
    number_of_days = (end_date - start_date).to_i - 1
    if number_of_days < 1
      number_of_days = 1
    end
    total_cost = number_of_days * 200
    return total_cost
  end
end
#Reservation.new_booking(start_date:'2012-02-01', end_date:'2012-02-03')
#ap Reservation.new_booking('2012-02-01',  '2012-02-03')
#binding.pry
#ap @@request_array
