require_relative './enigma'
enigma = Enigma.new

File.foreach('./lib/message.txt') do |line|
  working_line = line.downcase.split(', ')
  if working_line.count == 3
  enigma.encrypt(working_line[0],working_line[1], working_line[2])
    enigma.encrypt_write
    puts "Created 'encrypted.txt' with the key #{enigma.key} and the date #{enigma.date}"
  elsif working_line.count == 2
    enigma.encrypt(working_line[0],working_line[1])
    enigma.encrypt_write
  elsif working_line.count == 1
    enigma.encrypt(working_line[0])
    enigma.encrypt_write
   end
end