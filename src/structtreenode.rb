
# vim: et

require_relative 'modeltreenode'

module Tui

  # Tree node representing a single struct model.
  class StructTreeNode < ModelTreeNode

    # Builder method to instantiate and insert a new tree element depending
    # on the model type.
    protected
    def instantiate ( model )
      if model.is_a? Model::Integer
        self << IntegerTreeNode.new( model, @idr )
      elsif model.is_a? Model::String
        self << StringTreeNode.new( model, @idr )
      elsif model.is_a? Model::Enum
        self << EnumTreeNode.new( model, @idr )
      elsif model.is_a? Model::Struct
        self << StructTreeNode.new( model,@idr )
      elsif model.is_a? Model::Container
        self << ContainerTreeNode.new( model, @idr )
      else
        raise "Unsupported class '%s'" % model.class
      end
    end # instantiate

    # Repopulate the subtree should the list of options has changed.
    public
    def refresh
      @nodes.clear
      @model.attributes.each do |name, attr|
        instantiate attr
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

