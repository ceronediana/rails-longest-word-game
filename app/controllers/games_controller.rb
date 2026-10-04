require "open-uri"
require "json"

class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { ("A".."Z").to_a.sample }
  end

  def score
    @word = params[:word].upcase
    @letters = params[:letters].split

    word_in_grid = @word.chars.all? do |letter|
      @word.chars.count(letter) <= @letters.count(letter)
    end

    url = "https://dictionary.lewagon.com/#{@word}"
    response = URI.parse(url).read
    data = JSON.parse(response)
    english_word = data["found"]

    if word_in_grid == false
      @message = "Sorry but #{@word} can't be built out of #{@letters.join(' ')}"
    elsif english_word == false
      @message = "Sorry but #{@word} does not seem to be a valid English word..."
    else
      @message = "Congratulations! #{@word} is a valid English word!"
    end
  end
end
