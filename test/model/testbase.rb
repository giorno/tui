#!/usr/bin/ruby

# vim: et

require 'ci/reporter/rake/test_unit_loader'
require 'test/unit'
require 'pp'

require_relative '../../src/model/base'

class BaseModelTestCase < Test::Unit::TestCase

  # Read-only base object to unblock testing.
  class RoBaseIf < Tui::Model::Base

    public
    def valid? ( value )
      return true
    end # valid?

  end # RoBase

  def setup
  end # setup

  def teardown
  end # teardown

  def test_accessors
    base = Tui::Model::Base.new( 'lab1' )
    assert base.label == 'lab1'
    assert base.value.nil?

    base.label = 'lab2'
    assert base.label == 'lab2'
  end # test_accessors

  # Test display string rendering.
  def test_to_s
    base = Tui::Model::Base.new( 'lab1', 'val99' )
    assert base.to_s == 'val99'
  end # test_to_s

  # Test the validation method.
  def test_valid?
    base = Tui::Model::Base.new( 'lab1' )
    ex = assert_raise( RuntimeError ) { base.valid?( 1 ); }
    assert_equal( 'Method Tui::Model::Base::valid? not implemented!', ex.message )
    ex = assert_raise( RuntimeError ) { base.value = 1; }
    assert_equal( 'Method Tui::Model::Base::valid? not implemented!', ex.message )
  end # test_valid?

  # Test the read-only setting
  def test_ro
    base = RoBaseIf.new( 'lab1', '', true )
    ex = assert_raise( RuntimeError ) { base.value = 1; }
    assert_equal( "Model 'lab1' is read-only", ex.message )
  end # test_ro

end # BaseModelTestCase

