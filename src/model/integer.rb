
# vim: et

require_relative 'base'

module Tui module Model

  # Model for integer number objects.
  class Integer < Base

    # Constructor.
    public
    def initialize ( label, value = 0, ro = false )
      super( label, value, ro )
      if not ro
        self.value = value # validation step
      end
    end # initialize

    # Check if the provided value is indeed an integer.
    # @override
    public
    def valid? ( value )
      return value.is_a? ::Integer
    end # valid?

    # @overriden
    public
    def from_s ( value )
      @value = Integer( value )
    end # from_s

  end # Integer

end # ::Model
end # ::Tui

