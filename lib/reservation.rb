require 'date'
# require_relative '../spec/spec_helper'
require 'pry'

module Hotel
  class Reservation
    attr_reader :check_in, :check_out, :room

    def initialize(check_in, check_out, room)
      @check_in = Date.parse(check_in)
      @check_out = Date.parse(check_out)
      @room = room
      @total_cost = 0
    end
  end
end
