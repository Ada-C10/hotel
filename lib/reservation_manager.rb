
module Hotel
  class ReservationManager

    def initialize
      @reservations = []
    end

    # As an administrator, I can reserve a room for a given date range
    def file_reservations(checkin_date, checkout_date)
      #@reservations << reservation
    end

    # As an administrator, I can access the list of all of the rooms in the hotel
    def list_available_rooms #(date?)
    end

    # As an administrator, I can access the list of reservations for a specific date
    def list_daily_reservations(date)
      #this will be the startdate -- or in the range
    end
    # As an administrator, I can get the total cost for a given reservation
    def get_total_cost(confirmation_id)
    end

  end
end
