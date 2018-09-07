require 'simplecov'
SimpleCov.start

require 'date'
require 'minitest'
require 'minitest/autorun'
require 'minitest/reporters'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

require_relative '../lib/reservation.rb'
require_relative '../lib/reservation_tracker.rb'
require_relative '../lib/room_block.rb'
