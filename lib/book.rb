# Nessary - do not remove
# gems
require "date"
require_relative "daterange"
require_relative "hotel"
require_relative "reservation"
# libfiles

# Optional - for developer use
require "pry"
require "awesome_print"

module HotBook
# Book class holds all reservations and searches through them
# Reservation.new(start_date:, end_date:) #optional: room_number: :1, room_rate: 200.0

  class Book
    attr_reader :reservations, :hotel

    def initialize
      @reservations = []
      @hotel = HotBook::Hotel.new #(room_count: 20, room_rate: 200.0)
    end

    def new_reservation(daterange) #DateRange class
      new_reservation = HotBook::Reservation.new(daterange)
      # Reservation.new(start_date:, end_date:) #optional: room_number: :1, room_rate: 200.0
      @reservations << new_reservation
      return new_reservation
      #
      # #suggested_room = suggest_room(daterange)
      # args = { room_number: default_room_number, # refactor in Wave 2 to suggest_room(daterange)
      #          room_rate: find_room_by_number(default_room_number)[:room_rate]
      #        }
      # # raise ArgumentError if room_number is not available during daterange
      # args = args.merge(daterange)

    end

    def find_room_by_number(query)
      raise ArgumentError, "Room number must be Symbol" unless query.is_a? Symbol
      raise StandardError, "No room by that number" unless all_room_numbers.include?(query)
      return room = all_rooms.find { |room| room[:room_number] == query}
    end

    def all_rooms
      return hotel.rooms
    end

    def all_room_numbers
      return all_rooms.values_at(:room_number)
    end

    def default_room_number
      return :1
    end

    def list_reservations_by_date(date) # change to DateRange (start = end)
      raise ArgumentError, "Invalid date (use Date.parse)" unless date.is_a? Date
      return list = reservations.select {|reservation| reservation.range.include? date}
    end

    # def available_rooms(daterange)
        # validate(daterange)
        #
        #
        # return list
# end

    # def suggest_room(daterange)
    #   validate(daterange)
    # return suggestion = available_rooms(daterange).first
    # end

  end

end

#Should DateRange be a class of its own? (I think so!)
