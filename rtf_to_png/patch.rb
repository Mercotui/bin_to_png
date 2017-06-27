require "chunky_png"

class Patch
    module Modes
        PATCHES=0
        PATCHES_GLYPHS=1
        GLYPHS=2
        DOTS=3
    end
    module Types
        SPACER=0
        SENTENCE_START=1
        WORD_START=2
        MID=3
        #WORD_END=4
    end

    def set(char, color, type = Types::MID)
        @char = char
        @color = ChunkyPNG::Color::rgb(color[0], color[1], color[2])
        @type = type
    end

    def to_img(mode, width, height, offset)
        case mode
        when Modes::PATCHES
            ret = to_patch(width, height, offset, @color)
        when Modes::GLYPHS
            ret = to_glyph(width, @color)
        else
            puts 'to_img INVALID MODE: "' + mode.to_s + '"'
        end

        return ret
    end

private
    def to_patch(width, height, offset, color)
        img = ChunkyPNG::Image.new(width + offset, height, ChunkyPNG::Color::TRANSPARENT)

        case @type
        when Types::SPACER
            top_offset = 0
            bottom_offset = 0
        when Types::SENTENCE_START
            top_offset = 0
            bottom_offset = 0
        when Types::WORD_START
            top_offset = 0
            bottom_offset = offset
        when Types::MID
            top_offset = offset
            bottom_offset = 0
        else
            puts 'to_patch invalid type: "' + @type.to_s + '"'
        end

        points = Array.new()
        points[0] = ChunkyPNG::Point(top_offset, 0)
        points[1] = ChunkyPNG::Point(60, 0)
        points[2] = ChunkyPNG::Point(60, height)
        points[3] = ChunkyPNG::Point(bottom_offset, height)
        img.polygon(points, @color, @color)
    end

    def to_glyph(width, color)
        #img = ChunkyPNG::Image.new(width + offset, height, ChunkyPNG::Color::TRANSPARENT)
        img = ChunkyPNG::Image.new(600, 300, ChunkyPNG::Color::WHITE)
        wr = ChunkyText::Writer.new(img,'default_font')
        wr.size = 30
        wr.color = ChunkyPNG::Color::BLACK
        wr.write("*",100,150)
        return img
    end
end
