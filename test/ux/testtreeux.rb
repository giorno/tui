#!/usr/bin/ruby

# vim: et

require_relative '../../src/model/container'
require_relative '../../src/model/integer'
require_relative '../../src/model/enum'
require_relative '../../src/model/string'
require_relative '../../src/model/struct'
require_relative '../../src/containertreenode'
require_relative '../../src/integertreenode'
require_relative '../../src/enumtreenode'
require_relative '../../src/stringtreenode'
require_relative '../../src/structtreenode'
require_relative '../../src/tree'

require 'pp'

idr = lambda { |m| if m.respond_to? :label then m.label else m.to_s end }

tree = Tui::Tree.new( 'variables', idr )
  tree << Tui::IntegerTreeNode.new( Tui::Model::Integer.new( 'ro-id', -1, true ), idr )
  tree << Tui::EnumTreeNode.new( Tui::Model::Enum.new( 'enum-model-node', { 'opt1' => 'val1', 'opt2' => 'val2', 'opt3' => 'val3' }, 'opt1' ), idr )
  tree << Tui::IntegerTreeNode.new( Tui::Model::Integer.new( 'integer-model-node', 42 ), idr )
  tree << Tui::StringTreeNode.new( Tui::Model::String.new( 'string-model-node', 'Lorem ipsum' ), idr )
  tree << Tui::StringTreeNode.new( Tui::Model::String.new( 'multiline-string-model-node', 'dolor sit', false, true ), idr )

  struct = Tui::Model::Struct.new( 'struct-model-node' )
    struct << Tui::Model::Integer.new( 'ro-id', -1, true )
    struct << Tui::Model::String.new( 'string', 'label1' )
    struct << Tui::Model::Enum.new( 'enum', { 'opt1' => 'val1', 'opt2' => 'val2' }, 'opt1' )
  tree << Tui::StructTreeNode.new( struct, idr )

  container = Tui::Model::Container.new( 'container-model-node' )
    struct = Tui::Model::Struct.new( 'struct-model-node' )
      struct << Tui::Model::Integer.new( 'ro-id', -1, true )
      struct << Tui::Model::String.new( 'string', 'label1' )
      struct << Tui::Model::Enum.new( 'enum', { 'opt1' => 'val1', 'opt2' => 'val2' }, 'opt1' )
    container.containees << struct
  tree << Tui::ContainerTreeNode.new( container, idr )


tree.navigate

