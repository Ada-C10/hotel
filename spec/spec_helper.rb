# Add simplecov
require 'simplecov'
SimpleCov.start

require 'minitest'
require 'minitest/autorun'
require 'minitest/reporters'

require_relative '../lib/room_booker'
require_relative '../lib/reservation.rb'
require_relative '../lib/room_block.rb'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

# Require_relative your lib files here!
