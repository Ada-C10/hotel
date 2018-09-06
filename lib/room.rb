require 'pry'

module Hotel
  class Room
    attr_reader :id, :reservations, :dates_booked
    def initialize(number)
      @id = number
      @reservations = []
      #@dates_booked = []
    end

    def find_available_room(start_date,end_date)
    end

    def is_available(start_date,end_date)
      @reservations.conflict?(check_in, check_out)
      #reject - rooms that are nto available for dates
    end

  end
end
