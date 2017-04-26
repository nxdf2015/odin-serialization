load "hangman.rb"
load "serialization.rb"


class Main
include Serialisation

  class << self
    def start
      def initialize
        new
      end
    end
end

  private
  def initialize
    menu
  end

  def menu
    puts  %{
        option:
          1 - start game
          2 - restore session
          3 - quit
      }
    begin
      puts "choice :"
      answer = gets.chomp.to_i
    end until [1,2,3].include? answer
    case answer
    when 1
      Game.start
    when 2
       session = Restore.new
       game = session.objects
       game.start_game unless object.nil?
    else
      exit
    end
  end
end
