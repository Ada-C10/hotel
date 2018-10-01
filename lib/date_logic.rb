module DateLogic
  def DateLogic.date_range_include?(reservation, date)
    if (reservation.check_in...reservation.check_out).cover?(date)
      return true
    else
      return false
    end
  end

  def DateLogic.date_ranges_exclusive?(
    old_check_in,
    old_check_out,
    new_check_in,
    new_check_out)

    existing_range_array = date_range_array(old_check_in, old_check_out)

    new_range_array = date_range_array(new_check_in, new_check_out)

    intersecting_dates = existing_range_array & new_range_array

    if intersecting_dates.empty?
      return true
    else
      return false
    end
  end

  def DateLogic.date_range_array(check_in, check_out)
    date_range = check_in...check_out
    return date_range.to_a
  end
end
