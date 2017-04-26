class Message

   class << self
     def start
      format %W{ #{"+-"*15}   #{"you must guess a word"} #{"limited to 6 try"}  #{"+-"*15}}
    end
     def request (length = 0)
        %Q{ enter a word  #{ "with " + length + "letter " if length > 0}}
     end

     def compare(answer)
       puts answer.split("").join(" ")
     end

    def invalid(letters)
      if letters.empty?
        %Q[ all letters invalid !]
      else
        %Q[ #{letters.split("").join(" ")} not a the right position]
      end
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
       puts %Q[ #{type}   #{history.keys.join("")}]
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


puts Message.start
puts Message.request
