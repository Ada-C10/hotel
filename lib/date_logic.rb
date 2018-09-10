module DateLogic
  def DateLogic.date_range_include?(reservation, date)
    if (reservation.check_in...reservation.check_out).cover?(date)
      return true
    else
      return false
    end
  end

  def DateLogic.date_ranges_exclusive?(
    existing_reservation,
    new_check_in,
    new_check_out)
    
    existing_range_array = date_range_array(
      existing_reservation: existing_reservation
    )

    new_range_array = date_range_array(
      check_in: new_check_in,
      check_out: new_check_out
    )

    intersecting_dates = existing_range_array & new_range_array

    if intersecting_dates.empty?
      return true
    else
      return false
    end
  end

  def DateLogic.date_range_array(
    existing_reservation: nil,
    check_in: nil,
    check_out: nil)

    if existing_reservation
      date_range = existing_reservation.check_in...existing_reservation.check_out
      return date_range.to_a
    elsif check_in && check_out
      date_range = check_in...check_out
      return date_range.to_a
    end
  end
end
