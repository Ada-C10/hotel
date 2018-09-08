module Hotel
  class Block
    attr_reader :id, :party, :date_range

    def initialize(input)
      @id = input[:id]
      @party = input[:party]
      @date_range = input[:date_range]
    end
  end
end
