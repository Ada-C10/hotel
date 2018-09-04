require 'simplecov'
SimpleCov.start
require 'minitest'
require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/pride'

require 'date'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

#our namespace module
module Hotel; end

# Require_relative your lib files here!
require_relative '../lib/room.rb'
require_relative '../lib/reservation.rb'
require_relative '../lib/hotel_manager.rb'
