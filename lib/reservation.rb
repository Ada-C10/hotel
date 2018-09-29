require 'date'
require 'pry'
require 'overlappable'

module Hotel


  class Reservation
    include Overlappable

    PRICE = 200.00
    DIS_PRICE = 150.00



    attr_reader :room_num
    attr_accessor :start_date, :end_date

    def initialize(start_date, end_date, room_num)
      @start_date = start_date
      @end_date = end_date
      @room_num = room_num

      check_dates(start_date, end_date)

    end


    def check_dates(start_date, end_date)
      if start_date > end_date
        raise ArgumentError, "start date has to before end date start date: #{@start_date}"
      end
    end

    def cost
      total = ((@end_date - @start_date) - 1) * PRICE
      return total
    end


    def block_room_cost
      total = ((@end_date - @start_date) - 1) * DIS_PRICE
      return total
    end



    def contains?(date)
      start_date <= date && end_date > date
    end







  end

end
