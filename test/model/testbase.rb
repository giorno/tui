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
    assert_equal false, base.modified
    assert base.parent.nil?

    base.label = 'lab2'
    assert base.label == 'lab2'
    base.modified = true
    assert_equal true, base.modified
    base.parent = self
    assert_equal self, base.parent
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

  # Test the 'disabled' flag
  def test_disabled
    base = RoBaseIf.new( 'lab1', '' )
    assert_equal false, base.disabled
    base.disabled = true
    assert_equal true, base.disabled
  end # test_disabled

  # Test the 'modified' flag
  def test_modified
    parent = RoBaseIf.new( 'parent', '' )
    base = RoBaseIf.new( 'lab1', '' )
    base.parent = parent
    assert_equal false, parent.modified
    assert_equal false, base.modified
    base.value = 'A'
    assert_equal true, parent.modified
    assert_equal true, base.modified
  end # test_modified

  def test_from_s
    base = Tui::Model::Base.new( 'lab1' )
    base.from_s 'lab2'
    assert_equal 'lab2', base.value
  end # test_from_s

end # BaseModelTestCase

