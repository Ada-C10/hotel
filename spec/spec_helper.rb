require 'date'
require 'simplecov'
SimpleCov.start
require 'csv'
require 'date'
require 'minitest'
require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/pride'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

#our namespace module
module Hotel; end

# Require_relative your lib files here!
require_relative '../lib/room.rb'
require_relative '../lib/reservation.rb'
require_relative '../lib/hotel_manager.rb'
require_relative '../lib/calendar.rb'

# csv test files
require_relative '../support/reservations.csv'
require_relative '../support/rooms.csv'
