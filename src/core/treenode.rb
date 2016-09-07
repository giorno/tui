
# vim: et

require_relative 'keyaction'
require_relative 'keymaker'
require_relative 'string'
require_relative 'term'

module Tui module Core

  # User Interface component for a single navigation tree node. Each node is
  # associated with a container or an object instance from the ::Model
  # namespace.
  class TreeNode
    attr_accessor :parent, :depth, :model, :key, :nodes, :keygen, :done
    attr_reader :idr

    ROOT_LABEL = 'root'

    # Ensapsulates properties and behaviour of information line in the subtree
    # rendering, such as shortcut keys, number of not displayed items, etc.
    class InfoLine

      public
      def initialize ( )
        @infos = Array.new
        @shortcuts = Array.new
      end # initialize

      # Add informational text.
      # @param text [String] informational text
      public
      def info ( text )
        @infos << text
      end # info

      # Add keyboard shortcut.
      # @param key [String] keyboard shortcut
      # @param text [String] shortcut description
      public
      def shortcut ( key, text )
        @shortcuts << [ key, text ]
      end # info

      # Compose the line and return it.
      public
      def to_s ( )
        if not @infos.empty? or not @shortcuts.empty?
          output = ''
          @infos.each do |info|
            output += info.gray42
            if info != @infos.last then output = " " end
          end
          @shortcuts.each do |shortcut|
            if shortcut == @shortcuts.first and not @infos.empty? then output += " " end
            output += shortcut[0].bold + '' + shortcut[1]
            if shortcut != @shortcuts.last then output += '  ' end
          end
          return output
        end
        return nil
      end # to_s

    end # InfoLine

    # Constructor.
    #
    # @param model [Object] object rendered at this tree node
    # @param idr [Proc] lambda to provide textual representation of the object, unique within this node's parent
    #
    # @warning idrs in parent and its children should have consistent behaviour
    # so that there are no issues connected with remapping of keys to labels
    # when kassign is called
    public
    def initialize ( model, idr = lambda{ |i| return i.to_s } )
      super( )
      @parent = nil
      @depth = 0
      @model = model
      @idr = idr
      @key = nil
      @keymaker = nil # only nodes with subnodes will need it
      @nodes = Array.new
      @filter = ''
      @actions = Hash.new
    end # initialize

    # Add a new subnode.
    # @param node [TreeNode] subnode to be added
    public
    def << ( node )
      @nodes << node
      node.parent = self
      node.depth = node.parent.depth + 1 # cache the depth
      if @keymaker.nil? then @keymaker = Tui::Core::KeyMaker.new( node.idr ) end # lazy initialization
      @keymaker << node.model
    end # append

    # Add a new key action to the node.
    # @param ka [KeyAction] key action structure
    public
    def addkey ( ka )
      @actions[ka.key] = ka
    end # addkey

    protected
    def refresh ( )
      raise "TreeNode::refresh is not reimplemented"
    end # refresh

    # Assign the navigation keys to the subnodes using the KeyMaker.
    protected
    def kassign ( )
      if not @keymaker.nil?
        inverse = Hash.new
        @keymaker.make.each do |key, model|
          inverse[@idr.call( model )] = key
        end
        @nodes.each do |node|
          node.key = inverse[@idr.call( node.model )]
          raise "Broken key in TreeNode::kassign()" unless not node.key.nil?
        end
        @keymaker = nil
      end
    end # kassigna

    # Compose the node label.
    #
    # @oaram filter [String] applied filter
    # @oaram filterinf [Boolean] render filter string information
    # @param key [Boolan] render the key
    # @param count [Boolean] render the subnodes count information
    # @return [String]
    protected
    def label ( filter, filterinf = true, key = true, count = true )
      # Render the key and the label 
      result = @model.nil? ? ROOT_LABEL : @idr.call( @model )
      if key
        result = "[".gray42 + @key[filter.length..-1].orange + "]".gray42 + " " + result
      end
      if count
        result += " c:".gray42 + "%d" % @nodes.length
      end
      if not @filter.empty? and filterinf
        result += " f:".gray42 + @filter
      end
      return result
    end # label

    # Render the tree path up to this tree node content. If key is not nil,
    # prune the subtree so that only the elements matching the key prefix are
    # rendered.
    #
    # @param collapsed [Boolean] if true, only this node is rendered at this level
    # @param recurse [Boolean] if true, render the subtree as well
    # @param filter [String] parent filter string
    public
    def render ( collapsed = false, recurse = true, filter = '' )
      kassign # NOOP if the keys were already assigned

      subset = Array.new
      if collapsed and recurse
        @nodes.each do |node|
          if not node.model.disabled and node.key.start_with?( @filter )
            subset << node
          end
        end
        # remove the last character from the filter and recurse if the current
        # filter does not match anything
        if not @filter.empty? and subset.empty?
          @filter = @filter[0..-2]
          render( collapsed, recurse, filter )
          return
        end
      end

      # Follow the trail to the root node and render each stop
      if not @parent.nil? and collapsed then @parent.render( true, false, '' ) end
      if @parent.nil? # root node
        print "\u2500\u2500" # -
      elsif collapsed # non-root collapsed node
        print "".ljust( @depth * 2 )
        print "\u2514\u2500" # L
      end

      # Render the key and the label 
      puts label( filter, ( collapsed and recurse ), ( not collapsed ), ( not @model.nil? and not @nodes.empty? ) )

      # Render children
      if collapsed and recurse
        subset.each do |node|
          print "".ljust( node.depth * 2 )
          print node == subset.last ? "\u2514\u2500" : "\u251c\u2500"
          node.render( false, false, @filter )
        end
        il = InfoLine.new
        if @model.nil? then il.shortcut( '←', 'quit' ) else il.shortcut( '←', 'back' ) end
        if not @filter.empty? then il.shortcut( 'del', 'reset' ) end
        @actions.each do |key, action|
          if action.pred.call() then il.shortcut( action.symbol, action.desc ) end
        end
        puts
        puts "".ljust( ( @depth + 1 ) * 2 + 2 ) + il.to_s
        puts
      end
    end # render

    # Custom handler of pressed keys.
    #
    # @return [Boolean] true to exit the .navigate() loop
    protected
    def onkeypress ( key )
      # left arrow or backspace: return
      if ( key == Tui::Core::Term::KEY_ARROW_LEFT or key == Tui::Core::Term::KEY_BACKSPACE ) and onexit
        @filter = ''
        return true
      # delete: erase filter
      elsif not @filter.empty? and key == Tui::Core::Term::KEY_DELETE
        @filter = ''
      elsif @actions.include?( key ) # custom key action
        return @actions[key].func.call
      else
        @filter += key
      end
      return false
    end # onkeypress

    # Handler of exit action.
    #
    # @return [Boolean] true if exit is allowed
    protected
    def onexit
      return true
    end # onexit

    # Perform interactive action on the tree node.
    public
    def navigate ( )
      @done = false
      @filter = '' # key prefix to filter the subnodes on
      while not @done do
        Tui::Core::Term::clrscr
        refresh
        render( true )
        c = Tui::Core::Term::getk
        if onkeypress c then return end
        @nodes.each do |node|
          if node.key == @filter and not node.model.disabled
            node.navigate
            @filter = ''
          end
        end
      end
    end # navigate

  end # TreeNode

end # ::Core
end # ::Tui

