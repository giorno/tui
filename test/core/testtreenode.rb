#!/usr/bin/ruby

# vim: et

require 'ci/reporter/rake/test_unit_loader'
require 'test/unit'
require 'pp'

require_relative '../../src/core/treenode'

class TreeNodeTestCase < Test::Unit::TestCase

  # Expose certain protected interfaces.
  class TreeNodeIf < Tui::Core::TreeNode

    public
    def label ( filter, filterinf, key, count )
      return super
    end # label

    public
    def kassign
      return super
    end # kassign

  end # TreeNodeIf

  # Simple data model to use in a TreeNode.
  class DummyModel
    attr_reader :label

    def initialize ( label )
      @label = label
    end # initialize

    def to_s
      return label
    end # to_s

  end # DummyModel

  def setup
  end # setup

  def teardown
  end # teardown

  # Call all TreeNode methods that are using the @idr member and test its
  # output.
  def test_idr
    node = TreeNodeIf.new( DummyModel.new( 'Mary' ) )
    assert node.label( '', true, false, false ) == 'Mary'
    node = TreeNodeIf.new( DummyModel.new( 'Mary' ), lambda { |i| return 'Lamb' } )
    assert node.label( '', true, false, false ) == 'Lamb'
  end # test_idr

  # Test that key assignment is restarted when a new element is added.
  def test_kreassign
    node = TreeNodeIf.new( DummyModel.new( 'parent' ) )
    node << TreeNodeIf.new( DummyModel.new( 'child1' ) )
    node.kassign
    node << TreeNodeIf.new( DummyModel.new( 'child2' ) )
    assert_nothing_raised RuntimeError do
      node.kassign
    end
  end # test_kreassign

end # TreeNodeTestCase

