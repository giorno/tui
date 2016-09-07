
# vim: et

require_relative 'modeltreenode'

module Tui

  # Tree node representing a single Boolean model.
  class BooleanTreeNode < ModelTreeNode

    # By choosing this option we toggle the value.
    #
    # @overriden
    public
    def navigate
      @model.toggle
    end # navigate

  end # BooleanTreeNode

end # ::Tui

