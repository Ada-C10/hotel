# gems the project needs
require "csv"
require "date"

# Optional - for developer use
require "pry"
require "awesome_print"

# project constants
ROOM_NUMBERS_FILENAME = "data/room_numbers.csv"
TEST_RESERVATION_FILENAME = "support/test_reservation_data.csv"
RESERVATION_DATA_FILENAME = TEST_RESERVATION_FILENAME #"data/reservation_data.csv"

# namespace module
module HotBook;
end

# all of the classes that live in the module
require_relative "lib/block.rb"
require_relative "lib/bookingsmanager.rb"
require_relative "lib/daterange.rb"
require_relative "lib/errors.rb"
require_relative "lib/hotel.rb"
require_relative "lib/reservation.rb"
