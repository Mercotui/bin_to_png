#!/usr/bin/ruby

#parse sentences
# for each sentence
#   for each word
#       for each syllable
#           create patch
#           set patch collor
#       set start of word as start
#       set end of word as end
#   set begin of sentence as begin
#   set end of sentence as end

class colored_patches
    @patches = new.array
    def add_sentence (sentence)
        word_list = sentence.split(",")
        word_list.each do |word|
            syllable_list = word.split(" ")
            syllable_list.each do |syllable|
                word_patches << create_patch(syllable)
            end
        word.last.role = "d"
        (sentence_patches << word_patches).flatten!
        end
        (@patches << sentence_patches).flatten!
    end

    def generate
        print @patches

        @patches.each do |patch|

    end
end

class patch
    color
    role
    module roles
        SENTENCE_START=0
        SENTENCE_END=1
        WORD_START=2
        WORD_END=3
    end

    def initialize(syllable)

    end

    def to_pixels
        
    end
end
