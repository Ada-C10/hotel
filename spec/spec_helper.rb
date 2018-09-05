require 'simplecov'
require 'minitest'
require 'minitest/autorun'
require 'minitest/reporters'
require_relative '../lib/reservation'
require_relative '../lib/room'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

# Require_relative your lib files here!
