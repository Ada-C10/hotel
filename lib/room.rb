require_relative 'reservation'

class Room

  attr_reader :room, :availablity, :start_date, :end_date


  def initialize(room)
    @room = room

  end

#keep track of room that is not available

  #set room to a variable to be available or not available-get dates from reservation method

  @start_date = ""
  @end_date = ""

  def availablity(date1, date2)
    if @start_date != date1 && @end_date != date2
      return ":available"
    else
      return ":not-available"
    end

  end

end
