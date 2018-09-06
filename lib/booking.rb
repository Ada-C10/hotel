require 'pry'
require 'time'
require 'date'

class BookingSystem
  attr_reader :rooms, :reservations,

  def initialize(rooms, reservations)
    # times loop to create an array of 20 rooms
    @rooms = []
    20.times do |room_num|
      room_num += 1
      @rooms << Room.new(room_num)
    end
    @reservations = []
  end

  # list all of the rooms in the hotel
  def list_rooms
    return @rooms
  end

  # list the reservations for a specific date
  def list_reservations(date)

    return @reservations.select {|reservation| reservation.start_date == date }
  end

  # checking for room availability before booking the room
  def room_availability(start_date, end_date)

    reserve_range = DateRange.new(start_date, end_date)
    # Looking through room, through the all the reservation of the room to check for availability
    # @room_reservations is an array and need to iterated

    # @rooms.each do |room|
    #   if room.room_reservations.all
    #   end
    #
    # end


  #   @rooms.each do |room|
  #     room_reservations.each do |reservation|
  #       binding.pry
  #       if reservation.date_range.include? reserve_range
  #         # break
  #       else
  #         return room
  #       end
  #       # next
  #     end
  #     # return room
  #   end
  #
  #   # Look throught reservations and find the
  #   @reservations.find {|reservation| reservation.end_date == start_date }
  #
  #
  #
  # end


  # return reservation.room
end

def make_booking(start_date, end_date)

  # find a room that is available
  room_to_book = room_availability(start_time, end_time)

  # Tallying the estimated total cost from the date range
  estimated_cost = reservation.cost_calculator

  info = {id: rand(1..300),
    room: room_to_book,
    start_date: start_date,
    end_date: end_date,
    total_cost: estimated_cost
  }
  # Creating an instance of a new reservation
  new_reserv = Reservation(info)
  # Addint this new reservation to the list (array) of reservations for the room in the room class
  room.add_bookings(new_reserv)
  # Adding this new reservation to the list (array) of reservations in the booking class
  @reservations << new_reserv

end



end
