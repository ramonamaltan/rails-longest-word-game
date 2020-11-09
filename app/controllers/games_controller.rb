require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = Array.new((5..10).to_a.sample) { ('A'..'Z').to_a.sample }
  end

  def english_word?(word)
    response = open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    json['found']
  end

  def compute_score(word)
    word.length
  end

  def included?(word)
    word.chars.all? { |letter| word.count(letter) <= word.count(letter) }
  end

  def score
    @word = params[:word]
    #iterate over word array and check if letter is in other array
    # computing the score
    # the word can't be built out of grid
    # check words letters against letters in grid
    # the word is valid english word
    # scrape english dictionary
    # the word is valid according to the grid & is an english word
    if @word.present?
      if included?(@word)
        if english_word?(@word)
          @score = compute_score(@word)
          @message = 'well done'
        else
          @score = 0
          @message = 'not an english word'
        end
      else
        @score = 0
        @message = 'not in the grid'
      end
    end
  end
end
