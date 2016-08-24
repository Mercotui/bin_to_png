#! /usr/bin/env ruby
require "chunky_png"
require_relative "../rtf_to_png/patch.rb"

WIDTH = 40
HEIGHT = 70

def draw()
    png = ChunkyPNG::Image.new(1920, 1080, ChunkyPNG::Color('purple'))
    green = ChunkyPNG::Color('green')
    blue = ChunkyPNG::Color('blue')
    idx = 0

    patch = Patch.new
    patch.set('6', green, Patch::Types::SENTENCE_START)
    puts("composing #" + idx.to_s)
    png.compose!(patch.to_img('patch', WIDTH, HEIGHT), (WIDTH * idx), 0)
    idx+=1

    patch.set('6', blue, Patch::Types::MID)
    puts("composing #" + idx.to_s)
    png.compose!(patch.to_img('patch', WIDTH, HEIGHT), WIDTH * idx, 0)
    idx+=1

    patch.set('6',green, Patch::Types::MID)
    puts("composing #" + idx.to_s)
    png.compose!(patch.to_img('patch', WIDTH, HEIGHT), WIDTH * idx, 0)
    idx+=1

    patch.set('6',blue, Patch::Types::WORD_START)
    puts("composing #" + idx.to_s)
    png.compose!(patch.to_img('patch', WIDTH, HEIGHT), WIDTH * idx, 0)
    idx+=1

    patch.set('6',green, Patch::Types::MID)
    puts("composing #" + idx.to_s)
    png.compose!(patch.to_img('patch', WIDTH, HEIGHT), WIDTH * idx, 0)
    idx+=1

    patch.set('6',blue, Patch::Types::MID)
    puts("composing #" + idx.to_s)
    png.compose!(patch.to_img('patch', WIDTH, HEIGHT), WIDTH * idx, 0)
    idx+=1

    patch.set('6',green, Patch::Types::WORD_START)
    puts("composing #" + idx.to_s)
    png.compose!(patch.to_img('patch', WIDTH, HEIGHT), WIDTH * idx, 0)
    idx+=1

    patch.set('6',blue, Patch::Types::MID)
    puts("composing #" + idx.to_s)
    png.compose!(patch.to_img('patch', WIDTH, HEIGHT), WIDTH * idx, 0)
    idx+=1

    patch.set('6',green, Patch::Types::SENTENCE_START)
    puts("composing #" + idx.to_s)
    png.compose!(patch.to_img('patch', WIDTH, HEIGHT), WIDTH * idx, 0)
    idx+=1

    patch.set('6',blue, Patch::Types::MID)
    puts("composing #" + idx.to_s)
    png.compose!(patch.to_img('patch', WIDTH, HEIGHT), WIDTH * idx, 0)
    idx+=1

    patch.set('6',green, Patch::Types::WORD_START)
    puts("composing #" + idx.to_s)
    png.compose!(patch.to_img('patch', WIDTH, HEIGHT), WIDTH * idx, 0)
    idx+=1

    patch.set('6',blue, Patch::Types::MID)
    puts("composing #" + idx.to_s)
    png.compose!(patch.to_img('patch', WIDTH, HEIGHT), WIDTH * idx, 0)
    idx+=1

    png.metadata['Author'] = "Mercotui's bin_to_png"
    png.save('test.png')
end

draw
