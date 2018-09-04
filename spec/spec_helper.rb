require 'simplecov'
SimpleCov.start

require 'minitest'
require 'minitest/autorun'
require 'minitest/reporters'
# Add simplecov

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

require_relative '../lib/booking_system.rb'
require_relative '../lib/reservation.rb'
# Require_relative your lib files here!
