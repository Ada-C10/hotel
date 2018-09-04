require 'date'
require 'pry'

class ReservationMaker

#input is start and end date
#output if, if a room is available, sends start, end, and room# to reservation to make an instance of reservation.

attr_reader :start_date, :end_date

@@reservations = []

  def initialize (start_date, end_date)
    @start_date = start_date
    @end_date = end_date
  end

  

  def self.reservations
  end
end
