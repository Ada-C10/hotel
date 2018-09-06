class Room
  attr_reader :number, :status

  def initialize(data)
    @number = data[:number]
    @status = data[:status]
    @ranges = []
  end

  def change_status
    @status = "unavailable"
  end

  def add_reservation(range)
    @ranges << range
  end

end
