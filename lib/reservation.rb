# Jacquelyn Cheng - Nodes

# Reservation: Keeps track of a single reservation's info.

module Hotel
  class Reservation
    attr_reader :checkin_date, :checkout_date, :confirmation_number, :rooms

    def initialize(checkin_date, checkout_date, confirmation_number)
      @checkin_date = checkin_date
      @checkout_date = checkout_date
      @rooms = []
      @confirmation_number = confirmation_number
    end

    # adds a room to the reservation and updates rooms status to :BOOKED
    # checkout_date status is not updated since guest leaves in morning
    # raises an ArgumentError if Room not provided or Room is already in reservation
    # returns updated rooms collection if successful
    def add_room(room)
      raise ArgumentError, "Must provide a Room." unless room.is_a? Room
      unless rooms.empty?
        room_nums = rooms.map { |room| room.room_num }
        raise ArgumentError, "Room already on reservation." if room_nums.include? room.room_num
      end
      checkin_date.upto(checkout_date.prev_day) do |date|
        room.change_room_status(date, :BOOKED)
      end
      rooms << room
      return rooms
    end

    # calculates total cost for all rooms over all nights
    # checkout_date nightly rate is not included since guest leaves in morning
    def total_cost
      total = 0
      rooms.each do |room|
        checkin_date.upto(checkout_date.prev_day) do |date|
          total += room.nightly_rate(date)
        end
      end
      return total.to_f.round(2)
    end
  end
end
