require 'date'
require 'pry'

require_relative 'reservation'

module Hotel
  class RoomBooking

    ROOMS = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]

    def initialize(start_date, end_date)

      @start_date = start_date
      @end_date = end_date
      @room_id = find_room_id(@start_date, @end_date)
      @booked_dates = {}

    end


    def create_date_array(start_date, end_date)
      number_of_nights = (end_date - start_date).to_i
      date_array = []
      number_of_nights.times do
        date_array << start_date
        start_date +=1
      end
      return date_array
    end


    def find_room_id
      @booked_dates.each do |room|
        room.each do |dates|

        end
      end
    end
    

    def add_booked_dates(room_id)
      #check to see if room id already exists in hash
      #if not, create new k/v pair
      date_array_by_room(x, x)


    end







    def add_booked_dates(id, start_date, end_date)
#returns hash of booked dates by room
    end






  end
end
