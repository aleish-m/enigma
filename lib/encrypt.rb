require_relative './enigma'
enigma = Enigma.new

enigma.read_message('./lib/message.txt', './lib/encrypted.txt', 'encrypt')