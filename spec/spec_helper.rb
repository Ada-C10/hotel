require 'minitest'
require 'minitest/autorun'
require 'minitest/reporters'

require 'simplecov'
SimpleCov.start

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

# Require_relative your lib files here!
