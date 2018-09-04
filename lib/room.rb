require 'pry'

module Hotel
  class Room
    attr_reader
    def initialize(number)
      @id = number
      @reservations = []
    end
  end
end
