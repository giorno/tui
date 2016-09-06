
# vim: et

require_relative 'modeltreenode'

module Tui

  # Tree node representing a single enum model.
  class EnumTreeNode < ModelTreeNode

    # Pseudo-model representing a single enum value.
    class Proxy
      attr_accessor :model, :label, :ro, :disabled

      # Constructor.
      # @param model [EnumProperty] property to proxy
      # @param option [String] option name
      public
      def initialize ( model, option )
        @model = model
        @label = option
        @ro = false # @todo does it ever make sense to be true?
        @disabled = false
      end # initialize

      # Inherit the model behaviour. Enum value is represented to the outside
      # by option name
      public
      def to_s
        return @label.to_s
      end # to_s

    end # Proxy

    # Tree node representing a specific enum value to set it on the enum
    # model.
    class ValueTreeNode < ModelTreeNode

      # Set the property value.
      public
      def navigate
        @model.model.value = @model.label
        @parent.done = true
        return true
      end # navigate

    end # ValueTreeNode

    # Repopulate the subtree should the list of options has changed.
    public
    def refresh
      @nodes.clear
      @model.options.each do |name, value|
        self << ValueTreeNode.new( Proxy.new( @model, name ), @idr )
      end
    end # refresh

    # Revert to the behaviour of the generic tree node.
    public
    def navigate
      # call grandparent since this needs the behaviour of an ordinary tree node
      Core::TreeNode.instance_method( :navigate ).bind( self ).call
      return true
    end # navigate

  end # EnumTreeNode

end # ::Tui

