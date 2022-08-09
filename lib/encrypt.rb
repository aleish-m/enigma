require_relative './enigma'
enigma = Enigma.new

first_file, second_file, *data = ARGV

if ARGV.length < 2 || second_file[-4..-1] != '.txt'
  puts "Needs at least 2 file names. (Must write to '.txt' file)"
  exit
elsif data.count > 0 && data.any? { |value| value.length > 6 }
  puts 'Please note: Date should be date in DDMMYY format. Key should be 5 digits.'
  exit
end

enigma.read_user_input(first_file, second_file, *data, 'encrypt')
