require 'rest-client'

class GamesController < ApplicationController
  def new
    @letters = ('A'..'Z').to_a.sample(10)
  end

  def score
    @word = params[:word]
    @letters = params[:letters].split(' ')
    response = RestClient.get "https://wagon-dictionary.herokuapp.com/#{@word}"
    @status = JSON.parse(response)
    @word_array = @word.upcase.scan(/\w/)
    @result =
      if @word_array.all? { |n| @letters.include?(n) } && @status['found'] == true
        "Congratulations! #{@word.upcase} is a valid English word!"
      elsif @word_array.all? { |n| @letters.include?(n) } && @status['found'] == false
        "Sorry but #{@word.upcase} does not seem to be a valid English word..."
      elsif !@word_array.all? { |n| @letters.include?(n) }
        "Sorry but #{@word.upcase} cannot be built out of #{@letters}"
      else
        'Hi'
      end
  end
end
