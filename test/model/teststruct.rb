#!/usr/bin/ruby

# vim: et

require 'ci/reporter/rake/test_unit_loader'
require 'test/unit'
require 'pp'

require_relative '../../src/model/string'
require_relative '../../src/model/struct'

class StructModelTestCase < Test::Unit::TestCase

  def setup
  end # setup

  def teardown
  end # teardown

  def test_assign
    struct = Tui::Model::Struct.new( 'lab1' )
    assert_true struct.to_s == 'lab1'

    struct.attributes['attr1'] = Tui::Model::String.new( 'str1', 'val1' )
    assert_equal( struct.attributes['attr1'].value, 'val1' )
    struct << Tui::Model::String.new( 'attr2', 'val2' )
    assert_equal( struct.attributes['attr2'].value, 'val2' )
  end # test_assign

  def test_bracket_operator
    struct = Tui::Model::Struct.new( 'lab1' )
    struct << Tui::Model::String.new( 'str1', 'val1' )
    struct << Tui::Model::String.new( 'str2', 'val2' )
    assert_equal( 'val1', struct['str1'].value )
    assert_equal( 'val2', struct['str2'].value )
  end # test_bracket_operator

end # StructModelTestCase

