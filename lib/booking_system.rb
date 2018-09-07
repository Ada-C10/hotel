module Hotel
  class BookingSystem
    # method to find a reservation based on an inspect date 'insp_date'
    def self.find_reservations_by_date(inspect_date)
      # standardize input date
      search_date = Date.parse(inspect_date)
      # select all reservation instances that have booked dates that match
      # the inspect date
      found_reservations = Hotel::Reservation.load_reservations.select do |reservation|
        reservation.booked_dates.include? search_date.to_s
      end
      found_reservations = 0 if found_reservations.empty?
      return found_reservations
    end

    # method to find reservation based on id
    def self.find_a_reservation(id)
      reservation = Hotel::Reservation.load_reservations.find { |rsv| rsv.id == id }
      raise ArgumentError, 'ID does not exist' if reservation.nil?
      return reservation
    end

    # method to return total cost based on reservation id
    def self.get_reservation_total(id)
      rsv = find_a_reservation(id)
      total = rsv.total_cost
      return total
    end


    def self.find_available_rooms(inspect_date)
      # load reservations
      rooms = find_reservations_by_date(inspect_date)
      # all_rooms = Room.all
      if rooms == 0
        avail_rooms = (Room.all).map { |room| room.id}
      else
        # map booked rooms to new array - flatten it
        booked = (rooms.map {|rsv| rsv.included_rooms }).flatten
        # binding.pry
        # search all room instances for rooms that don't match
        rooms_arr = (Room.all).map { |room| room.id}
        avail_rooms = rooms_arr - booked
      end
      # binding.pry
      return avail_rooms
    end


  end # class
end # module