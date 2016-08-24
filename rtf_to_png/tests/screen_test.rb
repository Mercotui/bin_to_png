#! /usr/bin/env ruby
require "chunky_png"
require 'ruby-rtf'
require_relative "../rtf_to_png/screen_of_patches.rb"

WIDTH = 40
HEIGHT = 70

rtf_text = File.open(ARGV[0]).read
test_screen = ScreenOfchars.new
test_screen.parse_rtf(rtf_text)
test_screen.generate
