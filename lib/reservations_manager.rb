require 'pry'

require_relative 'room'
#reservations manager
module Hotel
  class ReservationsManager
    attr_reader :rooms, :reservations
    def initialize(number_of_rooms)
      @rooms = []
      (1..number_of_rooms).each do |number|
        @rooms << Room.new(number)
      end
      @reservations =[]
    end

  def reserve_room(start_date, end_date)
    #create instance of reservation
    #find available room, assign room to reservation id
  end
end
