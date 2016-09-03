
# vim: et

require_relative 'base'

module Tui module Model

  # Model for structure like objects. Each structure has named members that can
  # be of any model.
  class Struct < Base
    attr_accessor :attributes

    # Constructor.
    #
    # @param label [String] enum name
    # @param options [Hash] map of enum options
    # @param value [String] option name for currently set value
    public
    def initialize ( label )
      super( label )
      @attributes = Hash.new
    end # initialize

    # Assign a new attribute using its label as the key.
    #
    # @param attribute [Base] a property
    # @todo enforce the type
    public
    def << ( attribute )
      @attributes[attribute.label] = attribute
    end # <<

    # Get attribute by name.
    #
    # @param key [String] attribute name
    # @return [Base]
    # @todo throw if not present
    public
    def [] ( key )
      return @attributes[key]
    end # []

    # Value is irrelevant in the structure.
    # @override
    public
    def valid? ( value )
      return true
    end # valid?

    # Overrides the parent and is expected to be overridden in the subclass.
    #
    # @override
    public
    def to_s
      return label.to_s
    end # to_s

  end # Struct

end # ::Model
end # ::Tui

