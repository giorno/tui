
# vim: et

require_relative 'term'
require_relative 'treenode'

module Tui

  # Tree structure displayed in the CLI, the parent node of all branches and
  # leaves.
  class Tree < TreeNode

    # Constructor.
    public
    def initialize ( label = nil )
      super( label )
    end # initialize
 
    # NOOP at this level
    def refresh
    end

    # Disable cursor and navigate into the root tree node.
    def navigate
      Tui::Term.cursor false
      super
      Tui::Term.cursor true
    end
  end # Tree

end # ::Tui

