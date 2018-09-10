require_relative 'reservation'

module Hotel

  class Room

    attr_reader :room_num

    def initialize(room_num)
      @room_num = room_num

    end

    # def vaild_room_num? (num)
    #   if !@room_num.between?(1,20) raise ArgumentError
    # end




  end
end



























#___________________________________________________________________________

#   def initialize(room)
#     @room = room
#
#   end
#
# #keep track of room that is not available
#
#   #set room to a variable to be available or not available-get dates from reservation method
#
#   @start_date = ""
#   @end_date = ""
#
#   def availablity(date1, date2)
#     if @start_date != date1 && @end_date != date2
#       return ":available"
#     else
#       return ":not-available"
#     end
#
#   end
#
# end
