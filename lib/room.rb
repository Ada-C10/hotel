require 'pry'
require 'awesome_print'
require 'date'

module Hotel
  class Room
    attr_reader :id
    attr_accessor :cost

    def initialize(id)
      @id = id
      @cost = 200
    end

  end
end
