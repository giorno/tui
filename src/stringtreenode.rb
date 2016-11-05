
# vim: et

require_relative 'modeltreenode'

require 'tempfile'

module Tui

  # Tree node representing a single model.
  class StringTreeNode < ModelTreeNode

    # Adds special handling (external editor) for multiline strings.
    public
    def navigate
      # do not edit RO properties
      if @model.ro then return end

      # use system EDITOR to edit multiline strings
      if @model.multiline
        editor = ENV['EDITOR']
        if editor.nil? then editor = 'vim' end

        tmp = Tempfile.new( 'tui' )
        begin
          tmp.write( @model.value )
          tmp.rewind
          system( editor, tmp.path )
          @model.value = from_s( tmp.read )
        rescue
          tmp.close
          tmp.unlink
        end
      else
        super
      end
    end # navigate

  end # StringTreeNode

37 end # ::Tui
