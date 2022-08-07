require_relative './enigma'
enigma = Enigma.new

first_file, second_file, *data = ARGV

if ARGV.length < 3 || (data[0].length != 6 || data[1].length != 6)
  puts "We need at least 2 file names and the date in DDMMYY"
  exit
end

puts first_file
puts second_file

enigma.read_message('./lib/message.txt', './lib/encrypted.txt', data, 'decrypt')