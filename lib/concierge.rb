require 'awesome_print'
require 'date'
require 'csv'
#concierge can ACCESS list of all rooms in hotel
#concierge can RESERVE reservation for date range
#concierge can ACCESS list of reservations on date
#concierge can ACCESS receipt for completed stay
#can datevar.strftime("%b %d, %Y")

module Lodging

  class Concierge
    attr_accessor :room_hash

    def initialize(room_count)
      Lodging.create_rooms(room_count) #creating rooms upon initialization
    end

    def all_rooms
      CSV.read('all hotel rooms.csv', headers: true).each do |room|
        print room
      end
    end

    def new_reservation(check_in, check_out)
      raise ArgumentError if Date.parse(check_out) < Date.parse(check_in)

        book_this = Lodging.reservation(all_rooms, status)
        book_this[:check_in] = Date.parse(check_in)
        book_this[:check_out] = Date.parse(check_out)

    end
  end
end
