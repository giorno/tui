
# vim: et

require_relative 'base'

module Tui module Model

  # Model for enumerable objects. Each enum has a map of options, mapping
  # option name to option value.
  class Enum < Base
    attr_accessor :options
    attr_writer :formatter # to control to_s behaviour

    # Constructor.
    #
    # @param label [String] enum name
    # @param options [Hash] map of enum options
    # @param value [String] option name for currently set value
    public
    def initialize ( label, options, value = '' )
      super( label, value )
      @options = options # @todo validate that all keys are Strings
      self.value = value # validation step
      @formatter = lambda { |v| return @options[@value].to_s }
    end # initialize

    # Check if the provided value is indeed a valid option name.
    # @override
    public
    def valid? ( value )
      return ( ( value.is_a? ::String ) and ( @options.include? value ) )
    end # valid?

    # @override
    public
    def to_s
      return @formatter.call( @value )
    end # to_s

  end # Enum

end # ::Model
end # ::Tui

