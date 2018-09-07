# Keeps track of 1 reservation
require_relative 'room'
require 'date'

# module Hotel
  class Reservation
    attr_reader :check_in_date, :check_out_date, :room

    def initialize(check_in_date, check_out_date, room)
      @check_in_date = check_in_date
      @check_out_date = check_out_date
      @room = room
      raise StandardError, 'The end date cannot be before the start date.' if check_out_date <= check_in_date
    end

    def nights_stayed
      return date_range = check_out_date - check_in_date
    end

    def rate
      nights_stayed * 200
    end
  end
# end
