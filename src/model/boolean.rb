
# vim: et

require_relative 'base'

module Tui module Model

  # Model for binary state objects.
  class Boolean < Base

    # Constructor.
    #
    # @param label [String] model label
    # @param value [Boolean] initial value
    # @param ro [Boolean] read-only flag
    # @param options [Array] strings to render true and false values
    public
    def initialize ( label, value = true, ro = false, options = [ 'yes', 'no' ] )
      super( label, value, ro )
      if not ro
        self.value = value # validation step
      end
      @options = options
    end # initialize

    # Check if the provided value is indeed an integer.
    # @override
    public
    def valid? ( value )
      return ( ( value.is_a? ::TrueClass ) or ( value.is_a? ::FalseClass ) )
    end # valid?a

    # Switch the state.
    public
    def toggle
      @value = ( not @value )
    end # toggle

    # Render the value string.
    def to_s
      return @options[@value ? 0 : 1]
    end # to_s

  end # Boolean

end # ::Model
end # ::Tui

