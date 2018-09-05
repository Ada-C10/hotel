class Reservation
  attr_reader :start_time, :end_time, :nights, :cost, :reservations, :id
  @@RATE = 200

  def initialize(data)
    @id = data[:id]
    @start_time = data[:start_time]
    @end_time = data[:end_time]
    sec = @end_time - @start_time
    @nights = sec.to_i / 86400
    @cost = @nights * @@RATE
    raise StandardError if sec < 0 #invalid range
  end

# # create a class that creates a class variables that adds reservations - a booking class
#   def add_reservation
#     @@reservations << self
#   end

  # def self.find(start_time, end_time)
  #   reservations = @@reservations.select {|instance| instance.start_time == start_time && instance.end_time == end_time} # returns instance in array
  # end

end
