class Reservation
  attr_reader :start_time, :end_time, :nights
  @@rate = 200
  def initialize(data)
    @start_time = data[:start_time]
    @end_time = data[:end_time]
    sec = @end_time - @start_time
    @nights = sec.to_i / 86400
  end

end
