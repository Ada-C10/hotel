require 'simplecov'
SimpleCov.start

require 'minitest'
require 'minitest/spec'
require 'minitest/autorun'
require 'minitest/reporters'
require 'date'
require 'pry'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

# Require_relative your lib files here!
require_relative '../lib/date_range'
require_relative '../lib/booking_system'
require_relative '../lib/reservation'
require_relative '../lib/block'
