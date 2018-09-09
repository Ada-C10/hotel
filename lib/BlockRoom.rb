class BlockRoom

  attr_reader :start_date, :end_date, :collection_of_rooms, :discounted_rate

  def initalize(args)
    @start_date = args[start_date]
    @end_note = args[end_date]
    @collection_of_rooms = # Will probably be equal to a helper method that
      # finds rooms available for the block (no more than 5)
    @discounted_rate = discounted_rate

  end

end
