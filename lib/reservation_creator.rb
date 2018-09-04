require 'date'

module Hotel
  class Reservation
    attr_reader :room_number, :check_in_date, :check_out_date

    def initialize(room_number = 1, check_in_date, check_out_date)
      @room_number = room_number.to_i
        raise ArgumentError, "Invalid room number, only 1 to 20 allowed" if room_number > 20
      @check_in_date = Date.parse("#{check_in_date}")
      @check_out_date = Date.parse("#{check_out_date}")
        raise ArgumentError, "Checkout date cannot be before checkin date" unless check_in_date < check_out_date
    end

    # def rooms_in_hotel
    #   rooms = [*"Room 1".."Room 20"]
    # end
    #
    # def show_all_rooms
    #   rooms_in_hotel.each_with_index { |room, number| return "#{number + 1}. #{room}"}
    # end
    #
    # def choose_room_by_date(chosen_room)
    #   rooms.select {|room| return room if chosen_room == room }
    # end
  end
end
