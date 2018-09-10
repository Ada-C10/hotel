class Room
  attr_reader :number, :status, :ranges, :blocks

  def initialize(data)
    @number = data[:number]
    # rooms do not store the last day. Last day is reservation last day - 1
    @ranges = []
    @blocks = []
  end

  def add_range(range)
    @ranges << range
  end

  def add_block(data)
    input_data = {}
    input_data[:range] = data[:range]
    input_data[:discounted_rate] = data[:discounted_rate]
    input_data[:status] = data[:status]
    @blocks << input_data
  end
  # def sort_ranges
  #   @ranges.sort_by { |range| object.start_time }
  # end
end
