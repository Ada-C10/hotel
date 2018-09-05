require 'date'

module Hotel
  class ReservationHub
    attr_reader :start_date, :end_date
    attr_accessor :reservation_id



    ROOMS = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]


    def initialize(all_reservations)

    end



    def add_reservation(reservation_id, start_date, end_date)
      reservation_id = create_id

      reservation = Reservation.new(reservation_id, start_date, end_date)

      @reservations << reservation
    end



    #create a new reservation id by adding 1 to total reservations
    def create_id
      new_id = @reservations.length + 1
    end



    def return_all_reservations
      @reservations
    end


  end

end
