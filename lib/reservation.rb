require 'date'
require 'booking'
require 'room'

class Reservation
  attr_reader :id, :start_date, :end_date

  def initialize(id, start_date, end_date)
    #add rooms_needed to def initialize
    # cost?
    # rooms_needed
    @id = id
    @start_date = start_date
    @end_date = end_date
  end
end

def select_room
end
