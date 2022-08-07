require_relative './enigma'
enigma = Enigma.new

first_file, second_file, *data = ARGV

if ARGV.length < 2
  puts "We need at least 2 file names"
  exit
elsif data.count > 0 && data.any?{|value| value.length > 6}
  puts "We need the date in DDMMYY format and a 5 digit key"
  exit
end

enigma.read_message(first_file, second_file, *data, 'encrypt')