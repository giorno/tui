
# vim: et

require_relative 'structtreenode'

module Tui

  # Tree node representing a single container model.
  class ContainerTreeNode < StructTreeNode

    # Repopulate the subtree should the list of options has changed.
    public
    def refresh
      @nodes.clear
      @model.containees.each do |containee|
        raise "Unsupported class '%s'" % containee.class unless containee.is_a? Tui::Model::Struct
        instantiate containee
      end
    end # refresh

  end # ContainerTreeNode

end # ::Tui

