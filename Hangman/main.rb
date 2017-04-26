load "hangman.rb"
load "serialization.rb"
load "message.rb"



class Main


  class << self
    def start
      def initialize
        new
      end
    end
end

  private
  def initialize
    start
  end

  def start
  loop do

      Message.main
      begin
        puts "choice :"
        answer = gets.chomp.to_i
      end until [1,2,3].include? answer
      case answer
        when 1
          Game.start
        when 2
           session = Restore.new
           game = session.restore
           game.start_game unless game.nil?
        else
          exit
      end
   end
 end
end



Main.new
