
# vim: et

require 'set'

module Tui module Core

  # n-ary tree based key determination structure. When all subnodes are
  # inserted, their names are shortened so that each has a unique key of
  # minimal length. That is achieved by collapsing the nodes which only have
  # one child.
  class KeyMaker

    # Single node in the n-ary tree.
    class Node
      attr_accessor :nodes, :item

      # The only valid characters are a-z, 0-9, _ and -.
      VALID = Set.new [ 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k',
                        'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v',
                        'w', 'x', 'y', 'z', '0', '1', '2', '3', '4', '5', '6',
                        '7', '8', '9', '-', '_' ]

      # Sets up a new node in the tree.
      public
      def initialize ( )
        @nodes = Hash.new # subnodes
        @item = nil # if not nil, this is a (pseudo)leaf node
      end # initialize

      # Recursively append new item.
      # @param suffix [String] the unprocessed part of the label (its tail)
      # @param item [Object] item to set on the leaf node
      public
      def append ( suffix, item )
        if suffix.length == 0
          @item = item
          return
        end
        edge = suffix[0]
	raise "Invalid edge character '%s'" % edge unless VALID.include?( edge )
        if not @nodes.has_key?( edge )
          @nodes[edge] = Node.new( )
        end
        @nodes[edge].append( suffix[1..-1], item )
      end # append

      # Collapse nodes with only one subnode.
      # @note uses DFS
      public
      def collapse
        @nodes.each do |edge, subnode|
          subnode.collapse
          if @nodes.length == 1 and subnode.item.nil?
            @nodes = subnode.nodes
          end
        end 
      end # collapse

      # Recursively generate key:item pairs
      # @note uses DFS
      # @param edges [String] current path in the tree (stack of a letter for each edge)
      # @param map [Hash] the result structure
      public
      def make ( edges, map )
        @nodes.each do |edge, node|
          # push new edge on the stack and visit subtre
          newedges = edges
          if @nodes.length > 1 then newedges += edge end
          node.make( newedges, map )
          # (pseudo)leaf node
          if not node.item.nil?
            if node.nodes.length > 1 then newedges += edge end
            map[newedges] = node.item
          end
        end
      end # make

    end # Node

    # Constructor
    # @param func [Proc] lambda to extract the item label
    public
    def initialize ( func )
      @func = func
      @root = Node.new( )
      @made = false
    end # initialize

    # Insert new item into the tree
    # @param item [Object] object to be inserted
    public
    def << ( item )
      @root.append( @func.call( item ), item )
    end # <<

    protected
    def collapse
      @root.collapse
    end # collapse

    # Generate key:label hash 
    # @return [Hash] key:label pairs
    public
    def make
      raise "Keys already generated, reinitialize the maker" unless not @made
      @made = true
      collapse
      result = Hash.new
      @root.make( '', result )
      # An edge case: only one entry in the tree, which has collapsed to
      # a single node without any edges.
      if result.length == 1 and result.keys[0] == ''
        return { @func.call( result[''] )[0] => result[''] }
      end
      return result
    end # make

  end # KeyMaker

end # ::Core
end # ::Tui

