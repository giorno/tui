#!/usr/bin/ruby

# vim: et

# Inject colorizing strings
# http://stackoverflow.com/questions/1489183/colorized-ruby-output
class String
  def black;     "\e[30m#{self}\e[0m" end
  def blackbg;   "\e[40m#{self}\e[0m" end
  def blue;      "\e[34m#{self}\e[0m" end
  def bluebg;    "\e[44m#{self}\e[0m" end
  def bold;      "\e[1m#{self}\e[22m" end
  def brown;     "\e[33m#{self}\e[0m" end
  def gray;      "\e[37m#{self}\e[0m" end
  def graybg;    "\e[47m#{self}\e[0m" end
  def green;     "\e[32m#{self}\e[0m" end
  def greenbg;   "\e[42m#{self}\e[0m" end
  def magenta;   "\e[35m#{self}\e[0m" end
  def magentabg; "\e[45m#{self}\e[0m" end
  def red;       "\e[31m#{self}\e[0m" end
  def redbg;     "\e[41m#{self}\e[0m" end
  def underline; "\e[4m#{self}\e[24m" end
  def nocolor;   self.gsub /\e\[\d+m/, "" end

  # 256 colors
  # http://misc.flogisoft.com/bash/tip_colors_and_formatting#colors2
  def indigo;    "\e[38;5;62m#{self}\e[0m" end
  def indigobg;  "\e[48;5;62m#{self}\e[0m" end
  def red2;      "\e[38;5;196m#{self}\e[0m" end
  def red2bg;    "\e[48;5;196m#{self}\e[0m" end
  def orange;    "\e[38;5;178m#{self}\e[0m" end
  def orangebg;  "\e[48;5;178m#{self}\e[0m" end
  def gray42;    "\e[38;5;242m#{self}\e[0m" end
  def gray42bg;  "\e[48;5;242m#{self}\e[0m" end
end # String

