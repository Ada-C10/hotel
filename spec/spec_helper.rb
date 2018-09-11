require 'simplecov'
SimpleCov.start
require 'minitest'
require 'minitest/autorun'
require 'minitest/reporters'


# Add simplecov

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

# Require_relative your lib files here!
require_relative '../lib/reservations_manager.rb'
require_relative '../lib/room.rb'
require_relative '../lib/reservations.rb'
