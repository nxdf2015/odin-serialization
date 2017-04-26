
require "yaml"



module Serialisation
  @@type = YAML

  def serialize(obj)

      @@type::dump(obj)
  end


  def deserialize

  end

end
class Session
 include Serialisation
end

class Storage < Session

  def initialize(game)
    @objs=  game
  end



  def to_file name_user
    puts "to file"
    open(%Q[#{name_user}.txt],"w"){|f|

    f.puts(serialize(@objs))
  }
 end



end


class Restore < Session
include Serialisation

  def initialize
    puts "name ?"
    @name = gets.chomp

  end

  def session_object
    find_user unless @name.nil?
  end

  def find_user
    object = nil
    file = %Q[#{@name}+".txt"]
    #  if  Dir.exist? file

       begin
       f =open(file){|f|
        object =   deserialise(f.readlines)
       }
    rescue Exception
      puts "error file"
    end
    object
  end
end
