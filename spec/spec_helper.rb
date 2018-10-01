require 'simplecov'
SimpleCov.start

require 'minitest'
require 'minitest/autorun'
require 'minitest/reporters'
require 'date'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

require_relative '../lib/reservation'
require_relative '../lib/date_range'
require_relative '../lib/booking_system'
require_relative '../lib/block'
