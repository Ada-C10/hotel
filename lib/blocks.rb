require 'date'
require_relative "reservation"
require_relative "date_range"
require 'pry'

module Hotel
  class Blocks

    # As an administrator, I can create a block of rooms
      #   To create a block you need a date range, collection of rooms and a discounted room rate
      #   The collection of rooms should only include rooms that are available for the given date range
      #   If a room is set aside in a block, it is not available for reservation by the general public, nor can it be included in another block

      attr_reader :collection_of_rooms, :date_range, :cost_per_night

      def initialize(collection_of_rooms, cost_per_night, check_in, check_out)
        @collection_of_rooms = collection_of_rooms
        @cost_per_night = cost_per_night
        @date_range = Hotel::DateRange.new(check_in, check_out)
      end
  end
end
