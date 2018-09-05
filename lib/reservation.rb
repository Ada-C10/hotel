require 'date'
require 'room'

module Hotel
  class Reservation
    attr_reader :start_day, :end_day, :room, :id
    @@reservations = []
    def initialize(room, start_day, end_day)
      @room = room
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
      @total_nights * 200
    end
#all below needs tests
    def create_reservation(room,start_day,end_day)
      new_reservation = Hotel::Reservation.new(room,start_day,end_day)
      @@reservations << new_reservation
      store_res_by_room(new_reservation)
      return new_reservation
    end

    def store_res_by_room(reservation)
      room = find_room(reservation.room_number)
      room.reservations << reservation
    end

    def find_res_by_date(date)
      @@reservations.select{|reservation| reservation.start_day <= date && reservation.end_day >= date}
    end
  end
end
