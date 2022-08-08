require_relative './enigma'
enigma = Enigma.new

first_file, second_file, *data = ARGV

if ARGV.length < 3
  puts "We need at least 2 file names and the key."
  exit
elsif  data.any?{|value| value.length > 6}
  "Please note: Date should be date in DDMMYY format."
  exit
end

enigma.read_message(first_file, second_file, *data, 'decrypt')