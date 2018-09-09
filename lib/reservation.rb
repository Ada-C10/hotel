require 'date'
require_relative 'room'
require_relative 'front_desk'


  class Reservation
    attr_reader :start_day, :end_day, :room

    def initialize(room, start_day, end_day,nightly_cost)
      @room = room
      @nightly_cost = nightly_cost
      @start_day = Date.parse(start_day)
      @end_day = Date.parse(end_day)
      dates_validation(@start_day, @end_day)
      @total_nights = nights_in_reservation
    end

    def dates_validation(start_day, end_day)
      raise StandardError.new "invalid dates" unless start_day < end_day
    end

    def nights_in_reservation
      nights = @end_day - @start_day
      return nights.to_i
    end

    def total_cost
      @total_nights * @nightly_cost
    end
  end
