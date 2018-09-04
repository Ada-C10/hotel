# Add simplecov
require 'simplecov'
SimpleCov.start

require 'minitest'
require 'minitest/autorun'
require 'minitest/reporters'


Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

# Require_relative your lib files here!
require_relative '../lib/room'
require_relative '../lib/reservation'
require_relative '../lib/reservation_manager'
