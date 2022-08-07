require_relative './enigma'
enigma = Enigma.new

first_file, second_file, *data = ARGV

if ARGV.length < 3 || data.any?{|value| value.length > 6}
  puts "We need at least 2 file names and the date in DDMMYY"
  exit
end

enigma.read_message(first_file, second_file, *data, 'decrypt')