
# vim: et

require_relative 'base'

module Tui module Model

  # Model for container like objects. Essentially a list of objects.
  class Container < Base
    attr_reader :containees

    # Constructor.
    #
    # @param label [String] container name
    public
    def initialize ( label )
      super( label )
      @containees = Array.new
    end # initialize

    # 'Official' interface to insert new entry.
    #
    # @param containee [Base] new container entry
    public
    def << ( containee )
      containee.parent = self
      @containees << containee
    end # <<

    # Value is irrelevant in the container.
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

