class Room
  def initialize(id)
    @id = id
    @unavailable_dates = []
    @status = :AVAILABLE
  end


  def self.list
    return "Room #{self.id}"
  end
end
