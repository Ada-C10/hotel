require 'date'
require 'pry'

module Hotel

  class Reservation
    attr_reader :room_num
    attr_accessor :start_date, :end_date

    def initalize (start_date, end_date, room_num)
    end


    def create_reservation(start_date, end_date, room_num)
      if  !valid_dates?(start_date, end_date) raise ArgumentError

      end



    end

  end




















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
