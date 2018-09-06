require 'awesome_print'
#room should CREATE ROOMS = yes
#room should STORE room information = yes
#room should STORE room status = yes
#room should STORE room costs = yes
#room should STORE all hotel rooms = yes

module Lodging

  class Room
    attr_reader :room_number, :status, :cost

    @@room_list = [] #to store all instances of rooms created

    def initialize(room_number, cost = 200)
      @room_number = room_number
      @cost = cost
      @status = :available
      @@room_list << self
    end

    def self.show_list #to show list as instances
      return @@room_list
    end

  end
end
