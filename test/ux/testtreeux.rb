#!/usr/bin/ruby

# vim: et

require_relative '../../src/model/string'
require_relative '../../src/model/integer'
require_relative '../../src/tree'

require 'pp'

idr = lambda { |m| if m.respond_to? :label then m.label else m.to_s end }
tree = Tui::Tree.new( 'variables', idr )
  tree << Tui::Core::TreeNode.new( Tui::Model::Integer.new( 'enum-model-node', 1 ), idr )
  tree << Tui::Core::TreeNode.new( Tui::Model::Integer.new( 'integer-model-node', 1 ), idr )
  tree << Tui::Core::TreeNode.new( Tui::Model::String.new( 'string-model-node', 'a' ), idr )
  tree << Tui::Core::TreeNode.new( Tui::Model::Integer.new( 'struct-model-node', 1 ), idr )

tree.navigate

