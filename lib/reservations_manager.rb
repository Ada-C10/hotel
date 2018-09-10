require 'pry'
require 'Date'

require_relative 'room'
require_relative 'reservations'
#reservations manager
module Hotel
  class ReservationManager
    attr_reader :rooms, :reservations
    def initialize(number_of_rooms)
      @reservations = []
      @rooms = []
      (1..number_of_rooms).each do |number|
        @rooms << Room.new(number)
      end
    end

    # def available_rooms(check_in, check_out)
    #   available_rooms = @reservations.reject {rooms != date_range}
    #     #loop through Reservations @match dates on the reservations#reject dates that match
    #     return available_rooms #array

    def find_room(id)
      @rooms.each do |room|
        if room.id == id
          return room
        end
      end
    end
    # end
    #
    # def booked_rooms(date)
    #   booked_rooms = @reservations.select {rooms == date_range}
    #   return booked_rooms #array

    def reserve_room(check_in, check_out)
      new_reservation = Reservation.new(@reservations.length + 1, check_in: check_in, check_out: check_out)
      assigned_room = @rooms[0]
      new_reservation.rooms << assigned_room
      find_room(assigned_room.id).reservations << new_reservation
      return new_reservation
    end



    def @reservations.all
      return @reservations
    end
    #create instance of reservation
    #find available room, assign room to reservation id
    #ask room - do you have availability


  end
end
