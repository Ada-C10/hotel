require 'minitest'
require 'minitest/autorun'
require 'minitest/reporters'

require 'simplecov'
SimpleCov.start

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

require_relative '../lib/booking_system'
require_relative '../lib/room'
require_relative '../lib/reservation'
