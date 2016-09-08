#!/usr/bin/ruby

# vim: et

require 'ci/reporter/rake/test_unit_loader'
require 'test/unit'
require 'pp'

require_relative '../../src/model/string'
require_relative '../../src/model/container'

class ContainerModelTestCase < Test::Unit::TestCase

  def setup
  end # setup

  def teardown
  end # teardown

  def test_parent
    cont = Tui::Model::Container.new( 'lab1' )
    entry = Tui::Model::String.new( 'str1', 'val1' )
    cont << entry
    assert_equal( cont, entry.parent )
  end # test_parent

end # ContainerModelTestCase

