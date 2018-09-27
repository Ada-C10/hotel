require 'simplecov'
SimpleCov.start

require 'minitest'
require 'minitest/autorun'
require 'minitest/reporters'
require 'date'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

require_relative '../lib/reservation'
require_relative '../lib/reservation_hub'
require_relative '../lib/room_block'
require_relative '../lib/date_range'
