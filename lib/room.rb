require 'awesome_print'
#room should CREATE ROOMS = yes
#room should STORE room information = yes
#room should STORE room status = yes
#room should STORE room costs = yes
#room should STORE all_hotel_rooms = yes

module Lodging

  class Room
    attr_reader :room_number, :status, :cost

    def initialize(room_number, cost = 200)
      @room_number = room_number
      @cost = cost
      @status = :available

      room = [@room_number, @cost, @status, nil, nil]

      CSV.open('data/all_hotel_rooms.csv', 'a+') do |row|
          row << room
        end
    end

    def self.available_room #to return one room with status available
      CSV.open('data/all_hotel_rooms.csv', 'r', headers: true) do |row|
        return row 
      end
    end

  end
end
