require 'pry'
# require 'Date'

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

    def find_room(id)
      @rooms.each do |room|
        if room.id == id
          return room
        end
      end
    end

    def booked_reservations(date)
      return reservations = @reservations.select {|reservation| reservation.find_reservation(date) == true}
    end
    #   return booked_rooms #array
    #use same find_reservation method for rooms select for available, reject for booked

    def reserve_room(check_in, check_out)
      new_reservation = Reservation.new(@reservations.length + 1, check_in: check_in, check_out: check_out)
      assigned_room = available_rooms(check_in, check_out).last#available_rooms
      new_reservation.rooms << assigned_room.id
      find_room(assigned_room.id).reservations << new_reservation
      @reservations << new_reservation
      return new_reservation
    end


    def available_rooms(check_in, check_out)
      available_rooms = self.rooms.select {|room| room.is_booked?(check_in, check_out) == false}
      #loop through Reservations @match dates on the reservations#reject dates that match
      return available_rooms #array
    end

    # def @reservations.all
    #   return @reservations
    # end
    #create instance of reservation
    #find available room, assign room to reservation id
    #ask room - do you have availability


  end
end
