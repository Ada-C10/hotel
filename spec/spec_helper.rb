require 'minitest'
require 'minitest/autorun'
require 'minitest/reporters'
# Add simplecov

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

require_relative '../lib/reservation'
require_relative '../lib/booking_system'
require_relative '../lib/block'
require_relative '../lib/block_reservation'
