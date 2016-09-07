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
    assert keys.has_key?( 'co' ), keys.to_s
    assert keys.has_key?( 'cp' ), keys.to_s
    assert keys.has_key?( 'n' ), keys.to_s
    assert keys.has_key?( 'cd' ), keys.to_s

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
    assert keys.has_key?( 'co1' ), keys.to_s
    assert keys.has_key?( 'co2' ), keys.to_s
    assert keys.has_key?( 'co3' ), keys.to_s
    assert keys.has_key?( 'co4' ), keys.to_s
    assert keys.has_key?( 'cor' ), keys.to_s
    assert keys.has_key?( 'cpc1' ), keys.to_s
    assert keys.has_key?( 'cpc2' ), keys.to_s
    assert keys.has_key?( 'cp1' ), keys.to_s
    assert keys.has_key?( 'cp2' ), keys.to_s
    assert keys.has_key?( 'n' ), keys.to_s
    assert keys.has_key?( 't' ), keys.to_s
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
    assert keys.has_key?( 'co' ), keys.to_s
    assert keys.has_key?( 'cp' ), keys.to_s
    assert keys.has_key?( 'n' ), keys.to_s
    assert keys.has_key?( 'cd' ), keys.to_s
  end # test_lambda

  # Raise an exception when invalid label character is entered
  def test_valid
    km = Tui::Core::KeyMaker.new( lambda { |i| return i } )
    ex = assert_raise( RuntimeError ) { km << 'cor 1'; }
    assert_equal( "Invalid edge character ' '", ex.message )
    ex = assert_raise( RuntimeError ) { km << 'cor\1'; }
    assert_equal( "Invalid edge character '\\'", ex.message )
    km << 'abcdefghijklmnopqrstuvwxyz0123456789-_'
    keys = km.make
    assert keys.has_key?( 'a' ), keys.to_s
    assert keys.length == 1
  end # test_valid

  # Test that an assert is raised on a subsequent call to the .make() method.
  def test_made
    km = Tui::Core::KeyMaker.new( lambda { |i| return i } )
    km << 'core1'
    keys = km.make
    assert keys.has_key?( 'c' ), keys.to_s
    assert keys.length == 1
    ex = assert_raise( RuntimeError ) { km.make; }
    assert_equal( "Keys already generated, reinitialize the maker", ex.message )
  end # test_made

  # Test that when one label is a prefix of another, it will not get discarded
  # and that artificial suffix in the form of the dot character is appended.
  def test_broken_prefix
    km = Tui::Core::KeyMaker.new( lambda { |i| return i } )
    km << 'cor'
    km << 'core1'
    keys = km.make
    assert_equal 2, keys.length
    assert keys.has_key?( 'r' ), keys.to_s
    assert keys.has_key?( '1' ), keys.to_s
    km = Tui::Core::KeyMaker.new( lambda { |i| return i } )
    km << 'cor'
    km << 'core1'
    km << 'core2'
    keys = km.make
    assert_equal 3, keys.length
    assert keys.has_key?( '1' ), keys.to_s
    assert keys.has_key?( '2' ), keys.to_s
    assert keys.has_key?( 'r' ), keys.to_s
    km = Tui::Core::KeyMaker.new( lambda { |i| return i } )
    km << 'cor'
    km << 'corr'
    km << 'core2'
    keys = km.make
    assert_equal 3, keys.length
    assert keys.has_key?( '.' ), keys.to_s
    assert keys.has_key?( 'r' ), keys.to_s
    assert keys.has_key?( 'e' ), keys.to_s
  end # test_broken_prefix

end # KeyMakerTestCase

