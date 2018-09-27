require 'date'
require 'pry'

module Hotel

  class Reservation

    PRICE = 200.00
    DIS_PRICE = 150.00



    attr_reader :room_num
    attr_accessor :start_date, :end_date

    def initialize(start_date, end_date, room_num)
      @start_date = start_date
      @end_date = end_date
      @room_num = room_num
      @reservations = []

      check_dates(start_date, end_date)

    end


    #Date.parse format: Date.parse("10/5/2018"), 10 is day, 5 is month
    def check_dates(start_date, end_date)
      if start_date > end_date
        raise ArgumentError, "start date has to before end date start date: #{@start_date}"
      end
    end

    def reservation_cost
      total = ((@end_date - @start_date) - 1) * PRICE
      return total
    end


    def block_room_cost
      total = ((@end_date - @start_date) - 1) * DIS_PRICE
      return total
    end


    def add_reservation(reservation)
      @reservations << reservation
    end

    def contains?(date)
      matches = []
      @reservations.each do |reservation|
        if reservation.start_date <= date && reservation.end_date > date
          matches << reservation
        end
        return matches
      end
    end



    # def overlap?(start_date, end_date)
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
