#!/usr/bin/ruby

# vim: et

require 'ci/reporter/rake/test_unit_loader'
require 'test/unit'
require 'pp'

require_relative '../../src/model/enum'

class EnumModelTestCase < Test::Unit::TestCase

  def setup
  end # setup

  def teardown
  end # teardown

  def test_assign
    base = Tui::Model::Enum.new( 'lab1', { 'val1' => '1', 'val99' => '99' }, 'val99' )
    base.value = 'val1'
    assert_true base.to_s == 'val1'
  end # test_assign

  # Test the validation method.
  def test_valid?
    assert_raise( RuntimeError ) { Tui::Model::Enum.new( 'lab1', { }, 1 ) }
    base = Tui::Model::Enum.new( 'lab1', { 'val1' => '1', 'val99' => '99' }, 'val99' )
    assert_false base.valid?( 1 )
    assert_true base.valid?( "val1" )
    ex = assert_raise( RuntimeError ) { base.value = 1; }
    assert_equal( 'Invalid value for model type Tui::Model::Enum!', ex.message )
  end # test_valid?

  def test_formatter
    enum = Tui::Model::Enum.new( 'enum1', {  '1' => 2, '2' => 4, '3' => 8 }, '1' )
    enum.formatter = lambda { |v| return ( 2**enum.options[v] ).to_s }
    assert_equal( '4', enum.to_s )
    enum.value = '3'
    assert_equal( '256', enum.to_s )
  end # test_formatter

end # EnumModelTestCase

