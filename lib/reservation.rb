class Reservation
  attr_reader :start_time, :end_time, :nights, :cost
  @@RATE = 200
  #@@all_reservations = []
  def initialize(data)
    @start_time = data[:start_time]
    @end_time = data[:end_time]
    sec = @end_time - @start_time
    @nights = sec.to_i / 86400
    @cost = @nights * @@RATE
    raise StandardError if sec < 0
  end

end
