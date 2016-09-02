
# vim: et

require_relative 'base'

module Tui module Model

  # Model for string objects.
  class String < Base

    # Constructor.
    public
    def initialize ( label, value = '', ro = false )
      super( label, value, ro )
      if not ro
        self.value = value # validation step
      end
    end # initialize

    # Check if the provided value is indeed a string.
    # @override
    public
    def valid? ( value )
      return value.is_a? ::String
    end # valid?

  end # String

end # ::Model
end # ::Tui

