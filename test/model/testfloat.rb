#!/usr/bin/ruby

# vim: et

require 'ci/reporter/rake/test_unit_loader'
require 'test/unit'
require 'pp'

require_relative '../../src/model/float'

class FloatModelTestCase < Test::Unit::TestCase

  def setup
  end # setup

  def teardown
  end # teardown

  def test_assign
    base = Tui::Model::Float.new( 'lab1', 1.1 )
    base.value = 1.2
    assert base.to_s == '1.2'
  end # test_assign

  # Test the validation method.
  def test_valid?
    ex = assert_raise( RuntimeError ) { Tui::Model::Float.new( 'lab1', 'x' ); }
    base = Tui::Model::Float.new( 'lab1' )
    assert_false base.valid?( 'a' )
    assert_true base.valid?( 1.3 )
    ex = assert_raise( RuntimeError ) { base.value = 'a'; }
    assert_equal( 'Invalid value for model type Tui::Model::Float!', ex.message )
  end # test_valid?

  def test_from_s
    base = Tui::Model::Float.new( 'lab1', 1.1 )
    base.from_s '1.2'
    assert base.value == 1.2
  end # test_from_s

end # FloatModelTestCase

