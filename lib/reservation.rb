require 'date'
require 'pry'

require_relative 'room_booking'

module Hotel
  class Reservation
    attr_reader :start_date, :end_date, :room_id

    def initialize(start_date, end_date)

      @start_date = start_date

      @end_date = end_date

      @total_cost = reservation_cost(@start_date, @end_date)

      @room_booking = Hotel::RoomBooking.new(start_date, end_date)

      # @room_id = Hotel::RoomBooking.find_room_id(start_date, end_date)

      validate_dates

    end


    #make sure there are valid start/end dates
    def validate_dates
      raise ArgumentError.new("The end date must be after the start date") if @end_date <= @start_date

      raise ArgumentError.new("The start date can't be nil") if @start_date == nil

      raise ArgumentError.new("The end date can't be nil") if @end_date == nil
    end


    #create array for all nights in the reservation
    def create_date_array(start_date, end_date)
      number_of_nights = (end_date - start_date).to_i
      date_array = []
      number_of_nights.times do
        date_array << start_date
        start_date +=1
      end
      return date_array
    end



    # def generate_date(year, month, day)
    #   return Date.new(year, month, day)
    # end

    def reservation_cost(start_date, end_date)
      nightly_cost = 200
      total_days = (end_date - start_date).to_i
      total_cost = total_days * nightly_cost
    end


    def find_room(start_date, end_date)


    end


  end
end
