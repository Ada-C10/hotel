require 'time'
require 'date'
require 'minitest'
require 'minitest/autorun'
require 'minitest/reporters'
require 'awesome_print'
require 'simplecov'
SimpleCov.start

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

# Require_relative your lib files here!
require_relative '../lib/hotel_rooms'
require_relative '../lib/reservations'
require_relative '../lib/availability'
require_relative '../lib/room'
