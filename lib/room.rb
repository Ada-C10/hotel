module Hotel
  class Room
    attr_reader :number

    def initialize(number)
      @number = number # should this be a string ?
    end

    # def check_availability(start_date, end_date)
    #   # Do..something with dates.
    #   # if date of check is within range
    #   # return boolean
    #   availability = true
    #   return availability
    # end # of check_availability

  end # of class Room
end # of module Hotel
