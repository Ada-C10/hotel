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
    @start_date = Date.parse(start_date)
      # check_date(start_date)

    @end_date = Date.parse(end_date)
      # check_date(end_date)
    
    if @end_date < @start_date
      raise StandardError, "invalid date range"
    end

  end

  # def check_date(date)
  #   regex = /^\d{4}-\d{1,2}-\d{1,2}$/
  #   max_result = start_date.match(regex)
  #   if max_result.nil?
  #     raise StandardError "Invalid Date"
  #   end
  # end




end
