require_relative 'reservation.rb'


class BookingManager

  attr_reader :rooms
  attr_accessor :reservations, :start_date, :end_date, :make_reservation


  def initialize
    @start_date = start_date
    @end_date = end_date
    @reservations = []
    @rooms = (1..20).to_a # <= not sure why I didn't just do this in the beginning.

    # Took this out but left the .times loop  commented out to show that after sleep and a clear head, I understand that there is no reason at all to define i outside of this loop or incriment it by one. It iterates 20 times...not i times. The i is just an iteration variable and will run from 0 - 20.
    # 20.times do |i|
    #   @rooms << i + 1
    # end
  end

  def find_available_room(start_date, end_date)
    requested_dates = (start_date...end_date).to_a

    # Changed to 0, defining outside of the while loop for scope so the room eventually point at a different value depending on which conditional is met. Originally put in room 237 because I had the movie The Shining on as background noise and I was frustrated and that was an attempt at amusing myself thru writing this insane method. Sorry, should have definately focused more or just let myself take a break or both.
    room = nil
    room_count = 1

    # sets up the while loop to run thru room numbers 0 - 20. This could also be done with until, or 20.times do. I would refactor that change in but in my attempt to answer other comments about what I was thinking with this method, I left it as the while loop. My first instinct when doing some while in progress thing is to use while, I think its just the first thing that worked for me back in jumpstart live and I am clutching to it. I'll make sure to really look if there are better/more clean options avaliable in the future.
    while room_count < 20

      # I put this conditional in because if there is nothing in the reservations array, room number 1 is assigned and the work is done.
      if @reservations.empty?
        room = 1
        return room
      end

      # Doing an each with index to cycle thru the reservations array with more than 1 entry in it.
      @reservations.each_with_index do |reservation, index|

        # My logic was that if the number is equal to the room number but there is no intersection between the reservation dates of the reservation object and the requested dates, then the room assigned becomes the value of index plus one. In my original draft of this method this part didn't exist but I thouht I had to throw this in to make sure that a room could be reserved if there were no date conflicts. This part should have been made into another method to check for date conflicts or better yet, a totally different class.
        if reservation.room == (index + 1) && (reservation.reservation_dates & requested_dates).length == 0
          room = index + 1
          return room

          # My logic was that if the reservation's room number does not equal to the index, then it'll return the room.
        elsif reservation.room != (index + 1)
          room = index + 1
          return room
        else
          room_count += 1
        end
      end
    end
  end


  def make_reservation(start_date, end_date)

    # set up a local variable within the range to find an avaliable room number on the dates requested
    room = find_available_room(start_date, end_date)

    # took out the if statement here about if the room number is included in the room number array, changed it to raise an error if the room number is returned as 0 from the find_available_room method.

    reservation = Reservation.new(room, start_date, end_date)
    @reservations << reservation


  end


end
