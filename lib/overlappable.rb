module Hotel
  module Overlappable

    def overlap?(s_date, e_date)
      start_date.between?(s_date, e_date) || end_date.between?(s_date, e_date) || (s_date < start_date && e_date > end_date) || (s_date > start_date && e_date < end_date)

    end

  end
end
