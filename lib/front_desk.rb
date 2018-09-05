require 'date'
require 'reservation'
require 'room'
require 'pry'

module Hotel
  class FrontDesk
      def initialize
        @reservations = []
        self.create_rooms
        @all_rooms = []

      end

      def self.create_rooms
        all_rooms = []
        i = 1
        20.times do
          Room.new(i)
          all_rooms << Room.new(i)
          i += 1
        end
        return all_rooms
      end


      def self.all
        self.create_rooms
      end

  end

end
