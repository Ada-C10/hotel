module HotBook
  class RoomIsTakenError < StandardError
  end

  class RoomIsBlockedError < StandardError
  end

  class BlockConflictError < StandardError
  end

  class NoRoomsAvailableError < StandardError
  end
end
