class Room
  attr_reader :number, :status

  def initialize(data)
    @number = data[:number]
    @status = data[:status]
  end
end
