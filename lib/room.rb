class Room
  attr_reader :number, :status, :ranges

  def initialize(data)
    @number = data[:number]
    @ranges = []
  end

  def add_reservation(range)
    @ranges << range
  end

end
