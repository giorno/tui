
# vim: et

require_relative 'base'

module Tui module Model

  # Model for floating point number objects.
  class Float < Base

    # Constructor.
    public
    def initialize ( label, value = 0.0, ro = false )
      super( label, value, ro )
      if not ro
        self.value = value # validation step
      end
    end # initialize

    # Check if the provided value is indeed a floating point number.
    # @override
    public
    def valid? ( value )
      return value.is_a? ::Float
    end # valid?

  end # Float

end # ::Model
end # ::Tui

