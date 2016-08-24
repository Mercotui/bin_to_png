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

    def add_sentence (sentence)
        word_list = sentence.split(",")
        word_list.each do |word|
            character_list = word.split(" ")
            character_list.each do |char|
                word_chars << patch.new.set(character)
            end
        word.last.role = "d"
        (sentence_chars << word_chars).flatten!
        end
        (@chars << sentence_chars).flatten!
    end

    def generate
        png = ChunkyPNG::Image.new(1920, 1080, ChunkyPNG::Color('purple'))

        @width = 20
        @height = (@width * 1.6).floor
        idx = 0
        loc_x = 0
        loc_y = 0

        while loc_y <= 1080 && @chars.each.count > idx do
            begin
                char_img = @chars[idx].to_img('patch', @width, @height)
                png.compose!(char_img, loc_x, loc_y)
                loc_x += @width
                idx += 1
                puts "#" + idx.to_s + ": (" + loc_x.to_s + ", " + loc_y.to_s + ")"
            rescue ChunkyPNG::OutOfBounds
                loc_x = 0
                loc_y += @height
            end
        end

        puts "finished! saving..."
        png.metadata['Author'] = "Mercotui's bin_to_png"
        png.save('test.png')
        puts "saved, exiting."
    end
end
