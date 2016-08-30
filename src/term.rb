#!/usr/bin/ruby

# vim: et

require 'io/console'

# Primitives to control the terminal output.
module Tui module Term

  KEY_RETURN     = "\r"
  KEY_ESCAPE     = "\e"
  KEY_DELETE     = "\e[3~"
  KEY_BACKSPACE  = "\177"
  KEY_ARROW_LEFT = "\e[D"
  KEY_CTRL_S     = "\u0013"

  # Wait for the user to press a key.
  # Rewritten according to https://gist.github.com/acook/4190379 to receive
  # non-printable keys.
  def self.getk
    STDIN.echo = false
    STDIN.raw!
    c = STDIN.getc.chr
    if c == "\e" then
      c << STDIN.read_nonblock(3) rescue nil
      c << STDIN.read_nonblock(2) rescue nil
    end
  ensure
    STDIN.echo = true
    STDIN.cooked!
    return c
  end

  # Interface to read a string variable from the keyboard with confirmation by
  # Enter and cancelling by escape.
  # @return [Array] first element is a Boolean [t: Enter pressed, f: Escape pressed], second the buffer
  def self.gets ( prompt = '> ' )
    cursor true
    c = ''
    buf = ''
    print prompt
    while c != KEY_RETURN and c != KEY_ESCAPE
      if c == KEY_BACKSPACE
        if not buf.empty? # erase last character
          buf = buf[0..-2]
          print "\b \b"
        end
      elsif c.length == 1
        buf += c
        print c
      end
      c = getk
    end
    cursor false
    return [ ( c == KEY_RETURN ), buf ]
  end # self.gets

  # Clear the screen and move the cursor to the top left corner
  def self.clrscr ( )
    print "\e[1J"
    print "\e[H"
  end

  # Show or hide the terminal cursor
  def self.cursor ( on = true )
    if on
      print "\e[?25h"
    else
      print "\e[?25l"
    end
  end # cursor

  # Get the width of the terminal.
  def self.termw; return `/usr/bin/env tput cols`.to_i; end

end # ::Term
end # ::Tui

