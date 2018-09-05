class DateRange

  def initialize(check_in,check_out)
    @check_in = Date.parse(check_in)
    @check_out = Date.parse(check_out)
    @range = (@check_in...@check_out)

    if @check_out < @check_in
      raise ArgumentError.new('The check-out date is before the check-in')
    end

  end

end
