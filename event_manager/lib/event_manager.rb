require "csv"


require 'sunlight/congress'
require "erb"


Sunlight::Congress.api_key = "e179a6973728c4dd3fb1204283aaccb5"


content =CSV.open "event_attendees.csv" , headers: true ,header_converters: :symbol

def clean_zip_code(zipcode)
   zipcode.to_s.rjust(5,"0")[0..4]
end

def clear_phone(phone)
  phone =  phone.gsub(/\(|\)|-|\.|\s|\+|e/i,"").strip
  phone = "" unless phone.length == 10 || (phone.length == 11 && phone[0] ==1 )
  phone = phone[1..-1] if phone.length == 11 && phone[0] == 1
  phone
end

def legislator_by_zip_code(zipcode)
  Sunlight::Congress::Legislator.by_zipcode(zipcode)
#egislators.collect do |legislator|

end

def save_thank_you_letter(id,form_letter)
  Dir.mkdir("output") unless Dir.exist? "output"
  filename = "output/thanks_#{id}"
  open(filename,"w")do |f|
    f.puts form_letter
  end
end

puts "EventManager Initialized!"


template_letter  = File.read "form_letter.erb"
erb_template = ERB.new template_letter

content.each do |row|
  id = row[0]
  name = row[:first_name]
  zip = clean_zip_code( row[:zipcode] )
  phone = clear_phone(row[:homephone])
  legislators  = legislator_by_zip_code(zip)


  form_letter = erb_template.result(binding)
  save_thank_you_letter(id,form_letter)


end
