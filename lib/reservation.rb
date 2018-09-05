require 'date'
require 'admin'


class Reservation
  attr_reader :id, :room, :start_date, :end_date

  def initialize(id, room, start_date, end_date)
    #add rooms_needed to def initialize
    # cost?
    # rooms_needed
    # I want the id to be Admin.reservations.length + 1 for id ... right?
    @id = id
    @room = room
    @start_date = start_date
    @end_date = end_date

  end


end
