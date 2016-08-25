#!/usr/bin/ruby
require 'chunky_png'
require 'ruby-rtf'
require_relative 'patch'

#parse sentences
# for each sentence
#   for each word
#       for each character
#           create patch
#           set patch collor
#       set start of word as start
#       set end of word as end
#   set begin of sentence as begin
#   set end of sentence as end

class ScreenOfchars
    def parse_rtf(rtf_text)
        @chars = Array.new
        doc = RubyRTF::Parser.new.parse(rtf_text)
        doc.sections.each do |section|
            mods = section[:modifiers]
            color = mods[:foreground_colour]
            text = section[:text]
            puts color.to_s + ": " + text

            text.each_char do |letter|
                if letter != ''
                    char = Patch.new
                    if color != nil
                        rgb = [color.red, color.green, color.blue]
                    else
                        rgb = [255, 255, 255]
                    end
                    char.set(letter, rgb)
                    @chars << char
                end
            end
        end
    end

    def generate (width, height)
        png = ChunkyPNG::Image.new(width, height, ChunkyPNG::Color('purple'))

        char_width = 19
        char_height = (char_width * 1.6).floor
        char_offset = (char_width * 0.5).floor
        idx = 0
        loc_x = 0
        loc_y = 0

        while loc_y <= height && @chars.each.count > idx do
            char_img = @chars[idx].to_img('patch', char_width, char_height, char_offset)
            if(loc_x == 0)
                char_img.crop!(char_offset, 0, char_width, char_height)
                loc_x_increment = char_width - char_offset
            else
                if(loc_x + char_img.width > width)
                    max_char_width = width - loc_x
                    char_img.crop!(0, 0, max_char_width, char_height)
                end
                loc_x_increment = char_width
            end
            if(loc_y + char_img.height > height)
                max_char_height = height - loc_y
                char_img.crop!(0, 0, char_img.width, max_char_height)
            end

            png.compose!(char_img, loc_x, loc_y)
            loc_x += loc_x_increment
            idx += 1
            puts "#" + idx.to_s + ": (" + loc_x.to_s + ", " + loc_y.to_s + ")"

            if(loc_x > width)
                loc_x = 0
                loc_y += char_height
            end
        end

        puts "finished! saving..."
        png.metadata['Author'] = "Mercotui's bin_to_png"
        png.save('test.png')
        puts "saved, exiting."
    end
end
