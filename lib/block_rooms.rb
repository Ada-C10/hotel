require 'pry'
require_relative 'room'
require_relative 'reservation'
require_relative 'hotel'
require 'overlappable'


module Hotel

  class Block
    include Overlappable



    attr_reader :start_date, :end_date, :blocked_rooms, :avail_rooms, :name


    def initialize(start_date, end_date, blocked_rooms, name)
      @start_date = start_date
      @end_date = end_date
      @blocked_rooms = blocked_rooms
      @avail_rooms = @blocked_rooms

      @name = name

    end


    def get_avail_room(number)
      rooms = []
      if (@avail_rooms.length) < number
        raise ArgumentError.new("not enough rooms")
      end
      number.times do
        rooms << @avail_rooms.pop
      end
      return rooms
    end


  end

end
