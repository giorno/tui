
# vim: et

require_relative 'booleantreenode'
require_relative 'containertreenode'
require_relative 'enumtreenode'
require_relative 'integertreenode'
require_relative 'modeltreenode'
require_relative 'stringtreenode'
require_relative 'structtreenode'

module Tui

  # Tree node representing a single struct model.
  class StructTreeNode < ModelTreeNode

    # Builder method to instantiate and insert a new tree element depending
    # on the model type.
    protected
    def instantiate ( model )
      if model.is_a? Model::Integer
        self << IntegerTreeNode.new( model, @idr )
      elsif model.is_a? Model::Boolean
        self << BooleanTreeNode.new( model, @idr )
      elsif model.is_a? Model::Float
        self << BooleanTreeNode.new( model, @idr )
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

    # Revert to the behaviour of the generic tree node.
    protected
    def label ( filter, filterinf, key, count )
      return Core::TreeNode.instance_method( :label ).bind( self ).call( filter, filterinf, key, count )
    end # label

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

