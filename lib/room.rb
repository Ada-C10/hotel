require 'time'
require_relative 'reservation'
require_relative 'front_desk'


  class Room

    attr_reader :room_number, :room_reservations, :block_reservations

    def initialize(room_number)
      @room_number = room_number
      @room_reservations = []
      @block_reservations = []
      if room_number > 20 || room_number < 1
        raise ArgumentError.new "NOT VALID ROOM NUMBER"
      end
    end

  def is_available?(date)
    @room_reservations.each do |reservation|
      return false if reservation.start_day <= date && reservation.end_day > date
    end
    return true
  end


end
