
require "yaml"



module Serialisation
  @@type = YAML

  def serialize(obj)
      @@type::dump(obj)
  end


  def deserialize data
     @@type::load(data)
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

  def restore
    find_user unless @name.nil?
  end

  def find_user
    object = nil
    file = %Q[#{@name}.txt]


     begin
        File.open(file,"r"){|f|
          data =  f.read
          puts data
        object =   deserialize(data)
       }
    rescue Exception=>e
      puts "user do not exist " unless  Dir.exist? file
      puts e.message
    end
    object
  end
end
