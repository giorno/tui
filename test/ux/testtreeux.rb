#!/usr/bin/ruby

# vim: et

require_relative '../../src/model/string'
require_relative '../../src/model/integer'
require_relative '../../src/modeltreenode'
require_relative '../../src/tree'

require 'pp'

idr = lambda { |m| if m.respond_to? :label then m.label else m.to_s end }
tree = Tui::Tree.new( 'variables', idr )
  tree << Tui::ModelTreeNode.new( Tui::Model::Integer.new( 'ro-id', -1, true ), idr )
  tree << Tui::ModelTreeNode.new( Tui::Model::String.new( 'enum-model-node', 'e' ), idr )
  tree << Tui::ModelTreeNode.new( Tui::Model::Integer.new( 'integer-model-node', 42 ), idr )
  tree << Tui::ModelTreeNode.new( Tui::Model::String.new( 'string-model-node', 'i' ), idr )
  tree << Tui::ModelTreeNode.new( Tui::Model::String.new( 'struct-model-node', 's' ), idr )

tree.navigate

