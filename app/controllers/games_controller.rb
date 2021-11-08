require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = ('A'..'Z').to_a.sample(10)
  end

  def letter_in_grid
    @answer.upcase.chars.all? { |letter| @grid.include?(letter) }
  end

  def exist_word
    url = "https://wagon-dictionary.herokuapp.com/#{@answer}"
    word_dictionary = open(url).read
    word = JSON.parse(word_dictionary)
    word['found']
  end

  def score
    @answer = params[:answer]
    @grid = params[:token]
    @result = if !letter_in_grid
                "Sorry but #{@answer.upcase} can't be built out of #{@grid}"
              elsif letter_in_grid && !exist_word
                "Sorry but #{@answer.upcase} does not seem to be a valid English word..."
              else
                "Congratulations! #{@answer.upcase} is a valid English word!"
              end
  end
end
