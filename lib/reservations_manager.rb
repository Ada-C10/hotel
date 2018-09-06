require 'pry'

require_relative 'room'
require_relative 'reservations'
#reservations manager
module Hotel
  class ReservationManager
    attr_reader :rooms, :reservations
    def initialize(number_of_rooms)
      @rooms = []
      (1..number_of_rooms).each do |number|
        @rooms << Room.new(number)
      end
      @reservations =[]
    end

  def reserve_room(check_in, check_out)
    number = @reservations.length + +1
    @rooms.is_available(check_in, check_out)
    new_reservation = Reservation.new(number, check_in, check_out)
    #create instance of reservation
    #find available room, assign room to reservation id
    #ask room - do you have availability
  end

  def
  end
end
