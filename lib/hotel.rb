class Hotel
  def initialize(reservarions, rooms)
    reservarions = array of hashes that are instance of reservations
    rooms =  array of hashes that are instance of room
    # list of block reservations  - array of hashes that are instance of block reservations
  end

  def make_reservation(checkin, checkout)
     reserve_room
     reservarions << Reservation.new(checkin, checkout)
  end

   def rooms
      rooms << 20.times generate Room
      returns rooms
    end

   def list_reservations
     returns reservarions
   end

   def list_rooms
     returns rooms
   end

   def find_reservation(date)
   end

   def reserve_room => helper method?
     find room with available status
     changes room status
     #add current_reservation
   end

   # def reserve_block
   # end
   #
   # def cancel_reservations
   # end

end
