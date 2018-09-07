#reserve an available room for a given date range
def make_reservation(start_time: Date.now, end_time: Date.now + 1, number_of_rooms: 1)
  # view_available_rooms_on(start_time, end_time)
  @all_rooms.each do |room|
    number_of_rooms.times do
      if room.reserved_dates.empty?
        reservation = Reservation.new({rooms: [room.room_num], start_time: start_time, end_time: end_time, price: 200.0})
        @reservations << reservation
        room.reserved_dates << {start_time: start_time, end_time: end_time}
      else
        room.reserved_dates.each do |reserved_dates|
          if !(reserved_dates[:start_time]...reserved_dates[:end_time]).include?(start_time) #&& room.block == :NA
            reservation = Reservation.new({rooms: [room], start_time: start_time, end_time: end_time, price: 200.0})
            @reservations << reservation
            room.reserved_dates << {start_time: start_time, end_time: end_time}
          else raise ArgumentError.new"There is no room available on that date"
          end
        end
      end
      return reservation
    end
  end
end
