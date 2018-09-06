
# Add simplecov
require 'simplecov'
SimpleCov.start do
  add_filter "/spec/"
end
require 'minitest'
require 'minitest/autorun'

require 'minitest/pride'
require 'minitest/reporters'
require 'date'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

# Require_relative your lib files here!
require_relative '../lib/Booking'
require_relative '../lib/Room'
require_relative '../lib/Reservation'
require_relative '../lib/BlockRoom'
require_relative '../lib/DateRange'
