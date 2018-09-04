class Room

  attr_reader :id, :reservations

  def initialize(id, reservations)
    @id = id.to_i
    if id.between?(1,20) == false
      raise ArgumentError, "Room id must be between 1 and 20. Given #{id}."
    end
    @reservations = reservations
  end
end
