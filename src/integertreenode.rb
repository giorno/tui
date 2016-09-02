
# vim: et

require_relative 'modeltreenode'

module Tui

  # Tree node representing a single model.
  class IntegerTreeNode < ModelTreeNode

    # @overriden
    protected
    def from_s ( value )
      return Integer( value )
    end # from_s

  end # IntegerTreeNode

37 end # ::Tui
