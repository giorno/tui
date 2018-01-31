
# vim: et

require_relative 'core/term'
require_relative 'core/treenode'
require_relative 'model/base'

module Tui

  # Tree node representing a single model.
  class ModelTreeNode < Core::TreeNode
    MAX_VAL_CHARS = 32

    # Append the property value to the label and do not render the key on RO
    # models.
    def label ( filter, filterinf, key, count )
      result = super( filter, filterinf, ( key and not @model.ro ), false ) + ': '
      val = @model.to_s
      if val.empty?
        result += '<empty>'.gray42
      else
        # Display at most MAX_VAL_CHARS characters, flatten multilines
        result += val.gsub( "\n", " " )[0..MAX_VAL_CHARS]
        if val.length > MAX_VAL_CHARS
          result += '...' # and add trailing ellipsis for longer values
        end
      end
      return result
    end # label

    public
    def navigate
      # do not edit RO properties
      if @model.ro then return end
      done, value = Tui::Core::Term.gets @model.label.to_s + '> '
      if done
        begin
          @model.from_s( value )
        rescue ArgumentError => ex
          # @todo implement error signalling
        end
      end
    end # navigate

    # @override
    public
    def refresh
      # noop
    end # refresh

  end # ModelTreeNode

end # ::Tui

