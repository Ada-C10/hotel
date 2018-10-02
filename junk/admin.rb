require 'awesome_print'
require 'date'
#concierge can VIEW reservations
#concierge can RESERVE reservation
#concierge can ACCESS receipt for completed stay
#concierge can ACCESS hotel room list = yes
#can datevar.strftime("%b %d, %Y")

module Lodging #namespace/container
  #similar to the main.rb of other projects
  class Concierge #small hotel
    attr_accessor :room_hash

    def initialize(room_count)
      Lodging.create_rooms(room_count) #creating rooms upon initialization
    end

    def all_rooms
      room_hash = []
      Room.show_list.each do |room|
        room_info = {}
        # room = "Room #{room.room_number} costs $#{room.cost} a night and is #{room.status}."
        room_info[:room_number] = room.room_number
        room_info[:price] = room.cost
        room_info[:status] = room.status

        room_hash << room_info
      end
      return room_hash
    end


    def new_reservation(check_in, check_out, block = 1)
      raise ArgumentError if Date.parse(check_out) < Date.parse(check_in)
      #
      # status = block > 1 ? :hold : :unavailable #hold if block, unavailable if single reservation

      # block.times do
        book_this = Lodging.reservation(all_rooms, status)
        book_this[:check_in] = Date.parse(check_in)
        book_this[:check_out] = Date.parse(check_out)
        ap book_this
      # end
      #
      # @room_hash.find do |room|
      #   room[:room_number] == book_this[:room_number]
      #   # book_this[:status] = :unavailable
      # end

      # booked[:status] = :unavailable

    end

    def search_reservation(date)


    end

  end


end
