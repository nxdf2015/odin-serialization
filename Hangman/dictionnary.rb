require "open-uri"

class Dictionnary

  Path = "http://scrapmaker.com/data/wordlists/twelve-dicts/5desk.txt"

class << self
  def load(debug = false )
    @@words ||= File.open("dict.txt","r").readlines if Dir.exist? "dict.txt"

    @@words ||= create
    puts %Q[ dictionnary loaded  #{size } words ] if debug
    @@words
  end

  def size
    @@words.length
  end

  def create
    @@words = []
    File.open("dict.txt","w"){ |f|
      open(Path).read.scan(/\w+/).each do |word|
         @@words << word
          f.puts(word)
        end
    }

  end

  def random_word
    load
    id= rand(size)
    @@words[id]
  end

end

end
