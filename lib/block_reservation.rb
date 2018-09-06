require 'date'
require 'admin'
require 'reservation'

class BlockReservation < Reservation
  attr_reader :id, :rooms, :start_date, :end_date

  def initialize(id, rooms, start_date, end_date)
    #can't use super because room is different than rooms?
    @id = id
    @start_date = Date.parse(start_date)
    @end_date = Date.parse(end_date)
    @rooms = rooms

    if @end_date < @start_date
      raise StandardError, "invalid date range"
    end
  end
end
