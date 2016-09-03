
# vim: et

require_relative 'modeltreenode'

module Tui

  # Tree node representing a single struct model.
  class StructTreeNode < ModelTreeNode

    # Repopulate the subtree should the list of options has changed.
    public
    def refresh
      @nodes.clear
      @model.attributes.each do |name, attr|
        if attr.is_a? Model::Integer
          self << IntegerTreeNode.new( attr, @idr )
        elsif attr.is_a? Model::String
          self << StringTreeNode.new( attr, @idr )
        elsif attr.is_a? Model::Enum
          self << EnumTreeNode.new( attr, @idr )
        elsif attr.is_a? Model::Struct
          self << StructTreeNode.new( attr, @idr )
        else
          raise "Unsupported class '%s'" % attr.class
        end
      end
    end # refresh

    # Revert to the behaviour of the generic tree node.
    public
    def navigate
      # call grandparent since this needs the behaviour of an ordinary tree node
      Core::TreeNode.instance_method( :navigate ).bind( self ).call
      return true
    end # navigate

  end # StructTreeNode

end # ::Tui

