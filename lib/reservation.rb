# the roal of this class is to calculate cost of a reservation, and check for invalid range
class Reservation
  attr_reader :start_time, :end_time, :nights, :cost, :reservations, :id

  def initialize(data)
    @id = data[:id]
    @start_time = data[:start_time]
    @end_time = data[:end_time]
    sec = @end_time - @start_time
    @nights = sec.to_i / 86400
    rate = 200 if data[:rate].nil?
    @cost = @nights * rate
    raise StandardError if sec < 0 #invalid range
  end
end
