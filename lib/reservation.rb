require 'Date'
require 'pry'
class Reservation
  attr_reader :name, :room_number, :check_in_date, :check_out_date, :nights_of_stay

  def initialize(input)
    nights_stay = []
    check_in = input[:check_in_date]
    check_out = input[:check_out_date]
    num_nights = (check_out - check_in) - 1
    num_nights.to_i.times do |i|
      night = check_in + i
      nights_stay << night
    end

    @name = input[:name]
    @room_number = input[:room_number]
    @check_in_date = input[:check_in_date]
    @check_out_date = input[:check_out_date]
    @nights_of_stay = nights_stay
  end
end
