class Room

  attr_reader :room


  def initialize(room, start_date, end_date)
    @room = room
    @start_date = start_date
    @end_date = end_date
  end

# status = ""
#   def availablity(date1, date2)
#       if @start_date != date1 && @end_date != date2
#         status == true
#       elseif
#         status = false
#       end
#       return status
#   end

end
