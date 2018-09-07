require 'date'
require 'pry'

module Hotel

  class Reservation
    @@reservations = []

    attr_reader :room_num
    attr_accessor :start_date, :end_date

    def initalize (start_date, end_date, room_num)
      @start_date = start_date
      @end_date = end_date
      @room_num = room_num
    end


#pushes each reservation that comes through this class via the self method, @@reservation class variable defined up top as an empty array
    def reservation_push
      @@reservations.push(self)
    end

#returns the array of all the reservations that have been instanced with this class
    def self.reservation_all
      return @@reservations
    end





    # def create_reservation(start_date, end_date)
    #   raise ArgumentError, "start date has to before end date start date: #{start_date}" if  !valid_dates?(start_date, end_date)
    # end




  end

end


























#___________________________________________________________________________


# COST = 200.00
#
# def initialize(start_date, end_date, hotel_room)
#   @start_date = start_date
#   @end_date = end_date
#   @hotel_room = hotel_room
# end


#calculate cost of a single reservation and make that be an attr_reader to access cost per reservation

# total_money = 0
# def cost (start_date, end_date)
#   start_date = Date.parse(@start_date)
#   end_date  = Date.parse(@end_date)
#   total_money = end_day - start_day
#   return (total_money * COST) - COST
# end

# end
