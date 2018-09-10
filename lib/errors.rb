module HotBook
  class RoomIsTakenError < StandardError
  end

  class RoomIsBlockedError < StandardError
  end

  class BlockConflictError < StandardError
  end
end
