
# vim: et

module Tui module Core

  # Representation of a single key action.
  class KeyAction
    attr_reader :key, :symbol, :desc, :pred, :func

    # Constructor.
    #
    # @param key [String] pressed key sequence, see term.rb for details
    # @param symbol [String] character(s) rendered as the key symbol
    # @param desc [String] text rendered next to the symbol in info line
    # @param pred [Proc] lambda to determine if the action should be rendered
    # @param func [Proc] lambda to be executed when the key is pressed
    #
    # @see term.rb
    def initialize ( key, symbol, desc, pred, func )
      @key = key
      @symbol = symbol
      @desc = desc
      @pred = pred
      @func = func
    end # initialize

  end # KeyAction

end # ::Core
end # ::Tui

