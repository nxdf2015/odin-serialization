load "serialization.rb"

class Player
    

   def initialize
     @history  = {invalid: {} , valid: {} }
     @try = 0

   end

   def guess
     gets.chomp

   end

  def history
    @history
  end


   def set_history(letters,type)
       letters.split("").each do |letter|
         @history[type][letter] ||= 0
         @history[type][letter] += 1

    end
  letters
  end

  def try
    @try+=1
  end

  def count
    @try
  end


end
