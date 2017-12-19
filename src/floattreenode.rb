
# vim: et

require_relative 'modeltreenode'

module Tui

  # Tree node representing a single model.
  class FloatTreeNode < ModelTreeNode

    # @overriden
    protected
    def from_s ( value )
      return Float( value )
    end # from_s

  end # FloatTreeNode

37 end # ::Tui
