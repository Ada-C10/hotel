class BlockRoom

  attr_reader :start_date, :end_date, :discounted_rate

  def initialize(start_date, end_date, discounted_rate)
    @start_date = start_date
    @end_note = end_date
    # @collection_of_rooms = # Will probably be equal to a helper method that
      # finds rooms available for the block (no more than 5)
    @discounted_rate = discounted_rate


  end

end
