# Keeps track of 1 reservation
require_relative 'room'
require 'date'

class Reservation < Room
  attr_reader :check_in_date, :check_out_date, :room

  def initialize(check_in_date, check_out_date, room)
    @check_in_date = check_in_date
    @check_out_date = check_out_date
    @room = room
  end


  # def total_cost_of_one_reservation()
  #
  # end
end
