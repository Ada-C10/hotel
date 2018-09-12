require 'minitest'
require 'minitest/reporters'
require 'minitest/autorun'
# Add simplecov

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

# Require_relative your lib files here!
require_relative '../lib/room'
require_relative '../lib/reservation'
require_relative '../lib/room_tracker'
