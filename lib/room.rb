require 'pry'

module Hotel
  class Room
    attr_reader :id
    attr_accessor :reservations

    def initialize(number)
      @id = number
      @reservations = []
    end

    def is_available(check_in: check_in, check_out: check_out)
      self.reservations.include?
  end
end
