class Room
  attr_reader :number, :status, :ranges

  def initialize(data)
    @number = data[:number]
    # rooms do not store the last day. Last day is reservation last day - 1
    @ranges = []
  end

  def add_range(range)
    @ranges << range
  end

  # def sort_ranges
  #   @ranges.sort_by { |range| object.start_time }
  # end
end
