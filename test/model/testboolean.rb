#!/usr/bin/ruby

# vim: et

require 'ci/reporter/rake/test_unit_loader'
require 'test/unit'
require 'pp'

require_relative '../../src/model/boolean'

class BooleanModelTestCase < Test::Unit::TestCase

  def setup
  end # setup

  def teardown
  end # teardown

  def test_assign
    base = Tui::Model::Boolean.new( 'lab1', true )
    base.value = false
    assert base.to_s == 'no'
  end # test_assign

  # Test the validation method.
  def test_valid?
    ex = assert_raise( RuntimeError ) { Tui::Model::Boolean.new( 'lab1', 'x' ); }
    base = Tui::Model::Boolean.new( 'lab1' )
    assert_false base.valid?( 'a' )
    assert_true base.valid?( false )
    ex = assert_raise( RuntimeError ) { base.value = 'a'; }
    assert_equal( 'Invalid value for model type Tui::Model::Boolean!', ex.message )
  end # test_valid?

  # Test rendering of strings
  def test_to_s
    bool = Tui::Model::Boolean.new( 'lab1', true, false, [ 'gold', 'manure' ] )
    assert_equal 'gold', bool.to_s
    bool.value = false
    assert_equal 'manure', bool.to_s
    bool.toggle
    assert_equal 'gold', bool.to_s
  end # test_to_s

end # IntegerModelTestCase

