require 'pry'
# require 'Date'

require_relative 'room'
require_relative 'reservations'
require_relative 'block'
#reservations manager
module Hotel
  class ReservationManager

    attr_reader :rooms, :reservations

    def initialize(number_of_rooms)
      @reservations = []
      @blocks = []
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
      return @reservations.select {|reservation| reservation.find_reservation(date) == true}
    end

    def reserve_room(check_in, check_out, number_of_rooms: 1 )
      new_reservation = Reservation.new(@reservations.length + 1, check_in: check_in, check_out: check_out)
      assigned_rooms = available_rooms(check_in, check_out).last(number_of_rooms)
      assigned_rooms.each do |room|
        new_reservation.rooms << room.id
        find_room(room.id).reservations << new_reservation
      end
      @reservations << new_reservation
      return new_reservation
    end

    def available_rooms(check_in, check_out)
      available_rooms = self.rooms.select {|room| room.is_booked?(check_in, check_out) == false}
      #loop through Reservations @match dates on the reservations#reject dates that match
      return available_rooms #array
    end

    def create_block(check_in, check_out, number_of_rooms: , discount_rate: 0.8)
      block = Block.new(@blocks.length + 1, check_in: check_in, check_out: check_out, number_of_rooms: number_of_rooms, discount_rate: discount_rate)
      rooms_to_hold = available_rooms(check_in, check_out).first(number_of_rooms)
      rooms_to_hold.each do |room|
        block.block_rooms << room.id
        find_room(room.id).reservations << block
      end
      @blocks << block
      return block
    end

#     def reserve_block(check_in, check_out, number_of_rooms: , block_id: @blocks.last.id)
#       block_reservation = Reservation.new(@reservations.length + 1, check_in: check_in, check_out: check_out)
# #refer to blok - create find block based on id return blocked rooms
#       available_rooms() check_out).last(number_of_rooms)
#       assigned_rooms.each do |room|
#         new_reservation.rooms << room.id
#         find_room(room.id).reservations << new_reservation
#       end
#       @reservations << block_reservation
#       return block_reservation
#     end
  end

      #how to account for multiple rooms for a rservation within a block_reservation

      # add additional room to reservation

    # def reserve_block(number_of_rooms, check_in, check_out, discount_rate: 0.80)
    #   while available_rooms(check_in, check_out).length > number_of_rooms
    #     block_reservation =  Reservation.new(@reservations.length + 1, check_in: check_in, check_out: check_out, discount_rate: discount_rate)
    #     assigned_rooms = available_rooms(check_in, check_out).first(number_of_rooms)
    #     assigned_rooms.each do |room|
    #       block_reservation.rooms << room.id
    #       find_room(room.id).reservations << block_reservation
    #     end
    #   end
    #   @reservations << block_reservation
    #   return block_reservation
    # end



    # def @reservations.all
    #   return @reservations
    # end
    #create instance of reservation
    #find available room, assign room to reservation id
    #ask room - do you have availability



end
