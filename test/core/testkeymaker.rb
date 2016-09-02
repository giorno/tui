#!/usr/bin/ruby

# vim: et

require 'ci/reporter/rake/test_unit_loader'
require 'test/unit'
require 'pp'

require_relative '../../src/core/keymaker'

class KeyMakerTestCase < Test::Unit::TestCase

  def setup
  end # setup

  def teardown
  end # teardown

  # Check whether the tree is collapsed properly and the keys are generated
  # correctly.
  def test_keys
    km = Tui::Core::KeyMaker.new( lambda { |i| return i } )
    km << 'core1'
    km << 'cpucore1'
    km << 'nic1'
    km << 'cdrom'
    keys = km.make
    assert keys.has_key?( 'co' )
    assert keys.has_key?( 'cp' )
    assert keys.has_key?( 'n' )
    assert keys.has_key?( 'cd' )

    km = Tui::Core::KeyMaker.new( lambda { |i| return i } )
    km << 'cor'
    km << 'core1'
    km << 'core2'
    km << 'core3'
    km << 'core4'
    km << 'cpucore1'
    km << 'cpucore2a'
    km << 'cpu1'
    km << 'cpu2'
    km << 'nic'
    km << 'therm_1'
    keys = km.make
    assert keys.has_key?( 'co1' )
    assert keys.has_key?( 'co2' )
    assert keys.has_key?( 'co3' )
    assert keys.has_key?( 'co4' )
    assert keys.has_key?( 'cor' )
    assert keys.has_key?( 'cpc1' )
    assert keys.has_key?( 'cpc2' )
    assert keys.has_key?( 'cp1' )
    assert keys.has_key?( 'cp2' )
    assert keys.has_key?( 'n' )
    assert keys.has_key?( 't' )
  end # test_keys

  # Test the lambda passed to extract the label.
  def test_lambda
    func = lambda { |i| return i[0] }
    km = Tui::Core::KeyMaker.new( func )
    km << [ 'core1' ]
    km << [ 'cpucore1' ]
    km << [ 'nic1' ]
    km << [ 'cdrom' ]
    keys = km.make
    assert keys.has_key?( 'co' )
    assert keys.has_key?( 'cp' )
    assert keys.has_key?( 'n' )
    assert keys.has_key?( 'cd' )
  end # test_lambda

  # Raise an exception when invalid label character is entered
  def test_valid
    km = Tui::Core::KeyMaker.new( lambda { |i| return i } )
    #assert_throw( RuntimeError.new, "Not thrown" ) do km << 'cor 1' end
    assert_raise RuntimeError do
      km << 'cor 1'
    end
    assert_raise RuntimeError do
      km << 'cor\1'
    end
    km << 'abcdefghijklmnopqrstuvwxyz0123456789-_'
    keys = km.make
    assert keys.has_key?( 'a' )
    assert keys.length == 1
  end # test_valid

  # Test that an assert is raised on a subsequent call to the .make() method.
  def test_made
    km = Tui::Core::KeyMaker.new( lambda { |i| return i } )
    km << 'core1'
    keys = km.make
    assert keys.has_key?( 'c' )
    assert keys.length == 1
    assert_raise RuntimeError do
      km.make
    end
  end # test_made

end # KeyMakerTestCase

