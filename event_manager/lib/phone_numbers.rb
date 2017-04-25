

require "csv"
require "date"

data = CSV.open "event_attendees.csv", headers: true ,header_converters: :symbol
DAY = [:monday ,:tuesday , :wednesday , :thursday ,:friday  , :saturday , :sunday ]


 def select(col,data)
   result =[]
   data.each do |row|
   result <<  yield(row[col])
 end
 result
end


def frequency(hours)
  freq= {}
  hours.each do |h|

    freq[h] ||= 0
    freq[h] += 1
  end
freq
end


def max_frequency(frequency)
   hmax = 0
   frequency[hmax] ||= 0
   frequency.keys.each { | k|
      f =  frequency[k]
      hmax= frequency[hmax] < f ? k : hmax
   }
   hmax
end


 hours = select(:regdate,data ) { |time|
  DateTime.strptime(time,"%m/%d/%y %H:%M").hour
  }


 data.rewind

 days = select(:regdate,data) {|time|

  id  = DateTime.strptime(time,"%m/%d/%y %H:%M").wday
  DAY[id]
 }



  puts %Q[ max hours frequency #{max_frequency(frequency(hours))} ]

  puts %Q[ max days frequency #{max_frequency(frequency(days))}]
