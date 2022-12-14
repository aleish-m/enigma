require_relative './enigma'
enigma = Enigma.new

first_file, second_file, *data = ARGV

if ARGV.length < 3 || second_file[-4..-1] != '.txt'
  puts "We need at least 2 file names and the key. (Must write to '.txt' file)"
  exit
elsif data.any? { |value| value.length > 6 }
  puts 'Please note: Date should be date in DDMMYY format.'
  exit
end

enigma.read_user_input(first_file, second_file, *data, 'decrypt')
