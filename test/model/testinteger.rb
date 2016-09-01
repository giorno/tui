#!/usr/bin/ruby

# vim: et

require 'ci/reporter/rake/test_unit_loader'
require 'test/unit'
require 'pp'

require_relative '../../src/model/integer'

class IntegerModelTestCase < Test::Unit::TestCase

  def setup
  end # setup

  def teardown
  end # teardown

  def test_assign
    base = Tui::Model::Integer.new( 'lab1', 1 )
    base.value = 11
    assert base.to_s == '11'
  end # test_assign

  # Test the validation method.
  def test_valid?
    ex = assert_raise( RuntimeError ) { Tui::Model::Integer.new( 'lab1', 'x' ); }
    base = Tui::Model::Integer.new( 'lab1' )
    assert_false base.valid?( 'a' )
    assert_true base.valid?( 1 )
    ex = assert_raise( RuntimeError ) { base.value = 'a'; }
    assert_equal( 'Invalid value for model type Tui::Model::Integer!', ex.message )
  end # test_valid?

end # IntegerModelTestCase

