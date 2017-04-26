# load a dictionnary
  #select randomly a word => secret_word  ex :hangman
# print - * length *secret_word
# start game :option
 # restore a old game : ask name user and start game
 #start
    #loop  until number try less than MAX
      #option
        #play
          #:ask user for a valid  word  (same length as secret_word) garesq
          #save : save game to a file
        #return answer
            # letter if valid ex -a-----
            # print letter use


load("message.rb")

load("player.rb")
load("serialization.rb")

load("dictionnary.rb")

class Array

  def find_letters(letter)
    index = []
    self.each_index do |i| index << i if  self[i] == letter end
    index
  end
end

class Numeric

  def min (other)
    self < other ? self : other
  end

end

class String
  def to_a
    self.split("")
  end
  def -(other)
  (  self.split("") - other.split("")).join("")
end
  def and other
    (self & other).keys
  end

  def &(other)
      freq =Hash.new
      (self.split("") & other.split("")).each do |letter|
        freq[letter] = self.count(letter).min(other.count(letter))
    end
    freq
  end
end




class Game


  class << self
     def start
       new
     end
  end


  def initialize(player = nil , secret = nil, debug = true)

    Message.start
    @secret = secret || Dictionnary.random_word.to_s
    @secret.downcase!
    puts @secret if debug
    @count = 12
    @player = player || Player.new
    start_game
  end

  def start_game
    loop do
      begin

        menu()
        @player.try
        puts Message.try @player.count
        puts Message.request
        word = ask_word()
        win  = compare(word)
       end until win || @player.count > @count
    puts Message.end_game( win,@secret )
    puts Message.new_game
    break if gets.chomp == "no"
    end
  end

 def ask_word
  begin
  word =  @player.guess
  test =  word.nil? ||  word.length !=  @secret.length
  puts "invalid word" if   test
  end  until !test
 word
 end

 def menu
   puts Message.menu
   i = gets.chomp

   if i == "1"
     #p self
     p self.is_a? Game
     storage = Storage.new(self)
     puts "name ?"
     name = gets.chomp
     p name
     p storage
     storage.to_file(name)
     exit
   elsif i == "2"
      exit
   end
end

  def compare word
    word.downcase!
    intersection = @secret  & word
    valid  = []

    intersection.each do |letter,count|
      #index_secret = { id / @secret[id] = letter }
      index_secret = @secret.split("").find_letters(letter)
      #index_word = { id / @word[id] = letter }
      index_word = word.split("").find_letters(letter)
      #intersection index_word and index_secret
      valid << (index_word & index_secret)|| []
    end
    valid =  valid.flatten!.uniq #index valid letter
    invalid =  (0...@secret.length).to_a
    # indice  invalid letter invalid of word
    invalid = invalid - valid if valid.length >0
    # clone @secret
    answer = @secret[0..-1]
    invalid.each do  |index|
      answer[index] = "_" #invalid letter
      end
    letter_invalid = invalid.map do |index| word[index] end.join("")
    letter_valid = valid.map do |index| word[index] end.join("")
     @player.set_history(letter_invalid,:invalid)
     @player.set_history(letter_valid,:valid)

     puts
     puts Message.compare(answer)
     puts
     puts Message.invalid (((word - letter_valid)  &  @secret).keys.join(""))
     puts
     puts Message.history("invalid",@player.history[:invalid])
     puts
     puts Message.history("valid",@player.history[:valid])
     puts
    @secret == word

 end


end
