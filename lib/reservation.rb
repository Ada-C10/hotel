require 'date'
require 'pry'

class Reservation
  attr_reader :start_date, :end_date, :hotel_room

  def initialize(start_date, end_date, hotel_room)
    @start_date = start_date
    @end_date = end_date
    @hotel_room = hotel_room
  end


# total_money = 0

  # def cost (start_date, end_date)
  #   start_day = Date.parse(start_date)
  #   end_day  = Date.parse(end_date)
  #   total_money = end_day - start_day
  #     return (total_money * 200) - 200
  # end

end
