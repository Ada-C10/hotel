require_relative 'reservation'

class Room

  attr_reader :room, :availablity


  def initialize(room)
    @room = room
    @availablity = availablity
  end


  #set room to a variable to be available or not available-get dates from reservation method

  # def availablity(date1, date2)
  #   if start_date != date1 && reservation.end_date != date2
  #     status == ":available"
  #     elseif
  #     status = ":not-available"
  #   end
  #   binding.pry
  #   return status
  # end

end
