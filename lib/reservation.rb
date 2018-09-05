require 'Date'
require 'pry'
require_relative 'room'

class Reservation
  attr_reader :name, :room_number, :check_in_date, :check_out_date, :nights_of_stay

  def initialize(input)

    check_in = input[:check_in_date]
    check_out = input[:check_out_date]
    check_valid_date_range(check_in, check_out)

    nights_stay = generate_nights(check_in, check_out)

    @name = input[:name]
    @room_number = input[:room_number]
    @check_in_date = input[:check_in_date]
    @check_out_date = input[:check_out_date]
    @nights_of_stay = nights_stay

  end

  def generate_nights(check_in, check_out)
    nights_stay = []
    num_nights = (check_out - check_in)
    num_nights.to_i.times do |x|
      night = check_in + x
      nights_stay << night
    end
    return nights_stay
  end

  def check_valid_date_range(check_in, check_out)
    if check_out < check_in
      return raise ArgumentError, 'Check_out date before check_in date.'
    end
  end

end
