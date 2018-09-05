require 'date'
# Responsability - Handle date methods

class Date

  def initalize(check_in, check_out)
    @check_in = check_in
    @check_out = check_out
  end

  def date_within_range?(date)
    return (check_in .. check_out).cover?(date)
  end

end

# Number of days

# True if date is within a range

# True if given date range overlaps with another date range (can't be reserved)
