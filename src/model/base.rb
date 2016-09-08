
# vim: et

module Tui module Model

  # Base model.
  class Base
    attr_accessor :parent, :label, :ro, :disabled, :modified
    attr_reader :value

    # Constructor
    #
    # @param label [String] model label
    # @param value [Mixed] model value
    # @param ro [Boolean] marks model as read only
    public
    def initialize ( label, value = nil, ro = false )
      @parent = nil
      @label = label
      @value = value
      @ro = ro
      @disabled = false
      @modified = false
    end # initialize

    # Setter with extra check for the value.
    #
    # @param val [Mixed] value to update
    public
    def value= ( val )
      raise "Invalid value for model type %s!" % self.class unless valid?( val )
      raise "Model '%s' is read-only" % @label unless not @ro
      if @value != val
        @modified = true
        if not @parent.nil?
          @parent.modified = true
        end
      end
      @value = val
    end # value=

    # Retrieve string representation of the value for display purposes.
    #
    # @return [String]
    public
    def to_s
      return @value.to_s
    end # to_s

    # Check if the value is a valid value for this model.
    #
    # @param value [Mixed] model value
    public
    def valid? ( value )
      raise "Method %s::valid? not implemented!" % self.class
    end # valid?

  end # Base

end # ::Model
end # ::Tui

