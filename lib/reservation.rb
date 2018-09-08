require 'date'
require 'pry'
require_relative 'room'

ROOM_COST = 200

module Hotel
  class Reservation
    attr_reader :name, :room_number, :check_in_date, :check_out_date, :nights_of_stay

    def initialize(input)

      check_in = input[:check_in_date]
      check_out = input[:check_out_date]
      Hotel::Helper_Method.check_valid_date_range(check_in, check_out)

      nights_stay = Hotel::Helper_Method.generate_nights(check_in, check_out)

      @name = input[:name]
      @room_number = input[:room_number]
      @check_in_date = input[:check_in_date]
      @check_out_date = input[:check_out_date]
      @nights_of_stay = nights_stay

    end

  end
end
