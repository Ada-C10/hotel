class Room
  attr_reader :room_num, :cost, :dates_booked
  attr_accessor :blocked_status

  def initialize(room_num: nil, cost: 200, dates_booked: [], blocked_status: "unblocked")
    @room_num = room_num
    @cost = cost
    @dates_booked = dates_booked
    @blocked_status = blocked_status

  end

  def is_available?(dates)
    date_availability = []
    dates.each do |date|
      if self.dates_booked.include?(date)
        date_availability << "no"
      else
        date_availability << "yes"
      end
    end
    if date_availability.all?("yes")
      return true
    else
      return false
    end
  end

  def add_booked_dates(dates)
    dates.each do |date|
      self.dates_booked << date
    end
  end
end
