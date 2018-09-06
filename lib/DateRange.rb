require 'date'
# Responsability - Handle date methods

class DateRange
  attr_reader :check_in, :check_out

  def initialize(check_in, check_out)
    @check_in = check_in
    if check_in.class != Date
      raise ArgumentError, 'Please enter a valid date (yyyy, mm, dd)'
    end
    @check_out = check_out
    if check_out.class != Date
      raise ArgumentError, 'Please enter a valid date (yyyy, mm, dd)'
    end
  end

  def date_within_range?(date)
    return (@check_in .. @check_out).cover?(date)
  end

  def number_of_days
    return (@check_out - @check_in).to_i
  end

  # Create method to check if two date ranges overlap
  # Use in booking to show rooms not reserved
  

end


# True if given date range overlaps with another date range (can't be reserved)
