class Message

   class << self
     def main
       puts  %{
           option:
             1 - start game
             2 - restore session
             3 - quit
         }
       end
     def new_game
       %{
         new game yes / no
       }
     end

     def end_game(win , secret)
       if win
         %Q[ WIN ]
       else
         %Q[ game over, the word was #{secret}]
       end
     end

     def loose word
       %Q[ loose word was : #{word}]
     end

     def start
      format %W{ #{"+-"*15}   #{"you must guess a word"} #{"limited to 6 try"}  #{"+-"*15}}
     end

     def request (length = 0)
        %Q{ enter a word  #{ "with " + length + "letter " if length > 0}}
     end

     def compare(answer)
        answer.split("").join(" ").center(25)
     end

    def invalid(letters)
        %Q[ #{letters.split("").join(" ")} not a the right position]  if letters.length > 0
    end

     def menu
       %{
         1- save game 2- exit . else continue
       }
     end

     def try (try)
       %Q[ number try #{try}]
     end

     def history (type,history)
      #  s = []
       puts %Q[ #{type}   #{history.keys.join(" ")}]
      #  history.each do |letter,count|
      #      s << %Q[#{letter} use #{count} time #{"s" if count >1}]
      #  end
      #  s.join("\n")
     end

      def format lines
        lines.map do |line| line.center(40) end.join("\n")
      end
    end
end

#
# puts Message.start
# puts Message.request
