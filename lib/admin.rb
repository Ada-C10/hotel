# Jacquelyn Cheng - Nodes

# Admin: Manages bookings for the hotel.

module Hotel
  class Admin
    attr_reader :rooms, :reservations, :blocks

    AVAILABLE_STARTING = Date.parse("2019-01-01")
    AVAILABLE_THRU = Date.parse("2019-12-31")
    ROOM_COUNT = 20

    def initialize
      # Creates an array of 20 Room objects, numbered 1-20
      @rooms = []
      ROOM_COUNT.times do |room_num|
        @rooms << Room.new(room_num + 1, AVAILABLE_STARTING, AVAILABLE_THRU)
      end
      # Creates empty hashes to which all reservations and blocks are added
      @reservations = {}
      @blocks = {}
    end

    # Makes a reservation by 1. finding an available room,
    # 2. updating its availability, 3. creating a new Reservation that has
    # that room, 4. adding that room to the list of reservations and to a block
    # if applicable, and 5. returning that new Reservation
    def make_reservation(checkin_date, checkout_date, room_quantity = 1, block = nil)
      valid_dates?(checkin_date, checkout_date) # validate dates
      valid_block?(checkin_date, checkout_date, block) unless block == nil
      confirmation_num = reservations.length + 1 # generate confirmation number
      new_res = Reservation.new(checkin_date, checkout_date, confirmation_num, block) # create res
      rooms = book_rooms(new_res, checkin_date, checkout_date, room_quantity, block) # find and book available rooms
      reservations[confirmation_num] = new_res # add to admin's list of reservations
      block.add_reservation(new_res) unless block == nil # add res to block and update block availability
      return new_res
    end

    def make_block(block_name, checkin_date, checkout_date, discount_rate, room_quantity = 1)
      valid_dates?(checkin_date, checkout_date) # check dates
      if room_quantity > 5 || room_quantity < 1
        raise ArgumentError, "Can only block between 1-5 rooms"
      end
      new_block = Block.new(checkin_date, checkout_date, block_name, discount_rate) # create block
      block_rooms(new_block, checkin_date, checkout_date, room_quantity)
      blocks[block_name] = new_block # add to admin's list of blocks
      return new_block
    end

    def list_reservations(date)
      if reservations.empty?
        return nil
      else
        return reservations.select { |confirmation, reservation|
          date >= reservation.checkin_date && date <= reservation.checkout_date
        }
      end
    end

    def find_reservation(confirmation_num)
      return reservations[confirmation_num]
    end

    def find_block(block)
      return blocks[block]
    end

    def list_available_rooms(checkin_date, checkout_date = nil)
      return rooms.select { |room| !room.is_available?(checkin_date, checkout_date) }
    end

    private # helper methods
      # raises ArgumentError if dates invalid
      def valid_dates?(checkin_date, checkout_date)
        if checkin_date > checkout_date
          raise ArgumentError, "Check-in date must be before check-out date."
        elsif checkin_date > AVAILABLE_THRU || checkout_date > AVAILABLE_THRU
          raise ArgumentError, "Hotel only has availability through #{AVAILABLE_THRU}."
        else
          return true
        end
      end

      def valid_block?(checkin_date, checkout_date, block)
        found_block = blocks.find do |block_name, existing_block|
          block == existing_block &&
          block.checkin_date == existing_block.checkin_date &&
          block.checkout_date == existing_block.checkout_date
        end
        if found_block == nil
          raise ArgumentError, "Block for #{block} not found."
        end
        return found_block
      end

      # returns an array of the requested number of available Rooms
      # changes rooms' status to :BOOKED for the selected dates
      # raises an error if not enough rooms availble for the dates/quantity requested
      def book_rooms(reservation, checkin_date, checkout_date, room_quantity = 1, block = nil)
        if block == nil
          selected_rooms = rooms.select { |room|
            room.is_available?(checkin_date, checkout_date)
          }
        else # block != nil
          selected_rooms = block.blocked_rooms.select { |room|
            room.is_available?(checkin_date, checkout_date)
          }
        end
        if selected_rooms.empty?
          raise RoomAvailabilityError, "No rooms available from #{checkin_date} to #{checkout_date}."
        elsif selected_rooms.length < room_quantity
          raise RoomAvailabilityError, "Only #{room_quantity} rooms available from #{checkin_date} to #{checkout_date}."
        else # get the requested number of rooms and change their status to booked
          booked_rooms = selected_rooms.first(room_quantity)
          booked_rooms.each { |room| reservation.add_room(room)}
          return booked_rooms
        end
      end

      # finds available rooms, adds them to the block, and updates their status
      # and nightly rate according to the block's info
      # raises an error if not enough rooms availble for the dates/quantity requested
      # returns an array of the newly blocked rooms
      def block_rooms(block, checkin_date, checkout_date, room_quantity = 1)
        selected_rooms = rooms.select { |room|
          room.is_available?(checkin_date, checkout_date)
        }
        if selected_rooms.empty?
          raise RoomAvailabilityError, "No rooms available from #{checkin_date} to #{checkout_date}."
        elsif selected_rooms.length < room_quantity
          raise RoomAvailabilityError, "Only #{room_quantity} rooms available from #{checkin_date} to #{checkout_date}."
        else
          blocked_rooms = selected_rooms.first(room_quantity)
          blocked_rooms.each { |room| block.add_room(room) }
          return blocked_rooms
        end
      end
  end

  class RoomAvailabilityError < StandardError
  end
end
