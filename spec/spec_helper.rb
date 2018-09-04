require 'minitest'
require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/reporters'


Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

# Require_relative your lib files here!
