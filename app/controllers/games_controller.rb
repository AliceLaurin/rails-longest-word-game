require "json"
require "open-uri"

class GamesController < ApplicationController

  def new
   small_letters = (0...10).map { ('a'..'z').to_a[rand(26)] }.join
   @letters = small_letters.upcase
  end

  def score
    @answer = params[:word]
    url = "https://wagon-dictionary.herokuapp.com/#{@answer}"
    word_serialized = URI.open(url).read
    word = JSON.parse(word_serialized)

    @answer_letters = @answer.upcase.chars

    @list_letters = params[:letters].chars
    @answer_letters.each do |letter|
      number_of_apparition_in_list = @list_letters.count(letter)
      number_of_apparition_in_answer = @answer_letters.count(letter)
      if @list_letters.include?("#{letter}") && number_of_apparition_in_answer <= number_of_apparition_in_list
        if word["found"] == true
          @score = "CONGRATULATIONS ! #{word["word"].upcase} is an valid english word ! Your score is #{word["length"]*10}"
        elsif word["found"] == false
          @score = "Sorry but #{word["word"].upcase} does not seem to be a valid english word.... !. Your score is 0"
        end
      else
        @score = "Sorry but #{word["word"].upcase} can't be built out of #{params[:letters]}. Your score is 0!"
      end
    end




    #  j'itère sur les lettres de mon mot
    #  pour chaque lettre, je vérifie si elle est présente dans la liste
    #  si non = failes
    #  si oui, je regarde combiend e fois elle est présente dans la liste
    #  si elle est présente dans mon mot au moins ou egal le nombre de fois dans ma liste = ok
    #  sinon, fail


  end

end
