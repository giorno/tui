#!/usr/bin/ruby

# vim: et

require 'ci/reporter/rake/test_unit_loader'
require 'test/unit'
require 'pp'

require_relative '../src/tree'

class TreeTestCase < Test::Unit::TestCase

  # Expose certain protected interfaces.
  class TreeIf < Tui::Tree
    public
    def label ( filter, filterinf, key, count )
      return super
    end
  end # TreeIf

  def setup
  end # setup

  def teardown
  end # teardown

  # Test root node label rendering.
  def test_label
    root = TreeIf.new( )
    assert root.label( '', true, false, false ) == 'root'
    root = TreeIf.new( 'Mary' )
    assert root.label( '', true, false, false ) == 'Mary'
  end # test_label

end # TreeTestCase

