
# vim: et

module Tui module Model

  # Base model.
  class Base
    attr_accessor :label, :value

    # Constructor
    #
    # @param label [String] model label
    # @param value [Mixed] model value
    def initialize ( label, value = nil )
      @label = label
      @value = value
    end # initialize

  end # Base

end # ::Model
end # ::Tui

