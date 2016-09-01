#!/usr/bin/ruby

# vim: et

require 'ci/reporter/rake/test_unit_loader'
require 'test/unit'
require 'pp'

require_relative '../../src/model/string'

class StringModelTestCase < Test::Unit::TestCase

  def setup
  end # setup

  def teardown
  end # teardown

  def test_assign
    base = Tui::Model::String.new( 'lab1', 'val99' )
    base.value = 'val1'
    assert base.to_s == 'val1'
  end # test_assign

  # Test the validation method.
  def test_valid?
    base = Tui::Model::String.new( 'lab1' )
    assert_false base.valid?( 1 )
    assert_true base.valid?( "A" )
    ex = assert_raise( RuntimeError ) { base.value = 1; }
    assert_equal( 'Invalid value for model type Tui::Model::String!', ex.message )
  end # test_valid?

end # StringModelTestCase

