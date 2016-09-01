
# vim: et

require_relative 'base'

module Tui module Model

  # Model for integer number objects.
  class Integer < Base

    # Constructor.
    public
    def initialize ( label, value = 0 )
      super( label, value )
      self.value = value # validation step
    end # initialize

    # Check if the provided value is indeed an integer.
    # @override
    public
    def valid? ( value )
      return value.is_a? ::Integer
    end # valid?

  end # Integer

end # ::Model
end # ::Tui

