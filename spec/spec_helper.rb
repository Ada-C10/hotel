require 'simplecov'
SimpleCov.start

require 'minitest'
require 'minitest/spec'
require 'minitest/autorun'
require 'minitest/reporters'
require 'date'
require 'pry'
# Add simplecov

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

# Require_relative your lib files here!
# require_relative 'hotel_spec'
# require_relative '../lib/hotel'

require_relative '../lib/reservation'
require_relative '../lib/date_range'
require_relative '../lib/reservation_manager'
