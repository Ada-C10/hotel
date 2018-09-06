# Jacquelyn Cheng - Nodes

# Block: Blocks off rooms at a certain rate during an event.


# User Stories
#
# - As an administrator, I can create a block of rooms
#     - To create a block you need a date range, collection of rooms and a discounted room rate
#     - The collection of rooms should only include rooms that are available for the given date range
#     - If a room is set aside in a block, it is not available for reservation by the general public, nor can it be included in another block
# - As an administrator, I can check whether a given block has any rooms available
# - As an administrator, I can reserve a room from within a block of rooms
#
# ### Constraints
#
# - A block can contain a maximum of 5 rooms
# - When a room is reserved from a block of rooms, the reservation dates will always match the date range of the block
# - All of the availability checking logic from Wave 2 should now respect room blocks as well as individual reservations


# class Reservation
#   attr_reader :checkin_date, :checkout_date, :nights, :nightly_rate, :room, :confirmation_number
#
#   def initialize(checkin_date, checkout_date, room, confirmation_number)
#     @checkin_date = checkin_date
#     @checkout_date = checkout_date
#     @nights = checkout_date - checkin_date
#     @nightly_rate = 200
#     @room = room
#     @confirmation_number = confirmation_number
#   end
#
#   def total_cost
#     return (nights * nightly_rate).to_f.round(2)
#   end
# end

module Hotel
  class Block < Reservation
    attr_reader :block
    attr_accessor :blocked_rooms_available, :blocked_rooms_booked

    def initialize(block, checkin_date, checkout_date, discount_rate, blocked_rooms_available = 5, rooms = nil, confirmation_number = nil)
      super(checkin_date, checkout_date, discount_rate, rooms, confirmation_number)
      @block = block
      if blocked_rooms_available.length > 5 || blocked_rooms_available.length < 1
        raise ArgumentError, "Between 1-5 rooms can be blocked at once."
      end
      @blocked_rooms_available = blocked_rooms_available
      @blocked_rooms_booked = []
    end


  end
end
