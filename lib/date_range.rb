class DateRange
  attr_reader :start_date, :end_date

# def res_start(start_time = '11:00'.strftime('%k%M'))
#   @res_start = res_start
# end
# def res_end(end_time = '15:00'.strftime('%k%M'))
#   @res_end = res_end
# end

  # def start_date
  #   @start_date = DateTime.new
  # end
  #
  # def end_date
  #   @end_date = DateTime.new
  # end

  def initialize(start_date, end_date)
    unless end_date > start_date
      raise ArgumentError.new("Your dates are incorrect)")
    end
    @start_date = start_date.DateTime.new
    @end_date = end_date.DateTime.new
  end

  def contains(date)
    return date >= @start_date && date < @end_date
  end

  def nights
    return @end_date - @start_date
  end

end
