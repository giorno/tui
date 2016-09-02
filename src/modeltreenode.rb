
# vim: et

require_relative 'core/term'
require_relative 'core/treenode'
require_relative 'model/base'

module Tui

  # Tree node representing a single model.
  class ModelTreeNode < Core::TreeNode

    # Append the property value to the label and do not render the key on RO
    # models.
    def label ( filter, filterinf, key, count )
      result = super( filter, filterinf, ( key and not @model.ro ), false ) + ': '
      val = @model.to_s
      if val.empty?
        result += '<empty>'.gray42
      else
        result += val
      end
      return result
    end # label

    public
    def navigate
      # do not edit RO properties
      if @model.ro then return end
      done, value = Tui::Core::Term.gets @model.label.to_s + '> '
      if done
        @model.value = value
      end
    end # navigate

    # @override
    public
    def refresh
      # noop
    end # refresh

  end # PropertyTreeNode

37 end # ::Tui
