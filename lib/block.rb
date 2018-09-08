module Hotel
  class Block
    attr_reader :id, :num_rooms, :date_range

    def initialize(input)
      @id = input[:id]
      @num_rooms = input[:num_rooms]
      @date_range = input[:date_range]
    end
  end
end
