require 'date'
require_relative './readable'
require_relative './shiftable'

class Enigma
  include Readable
  include Shiftable
  attr_reader :characters, :message, :key, :date, :encryption

  def initialize
    @characters = ('a'..'z').to_a << ' '
    @message = ''
    @key = ''
    @date = ''
    @encryption = ''
  end

  def encrypt(incoming_phrase, incoming_key = generate_key, incoming_date = generate_date)
    if incoming_key.length == 6 && incoming_date == generate_date
      incoming_date = incoming_key
      incoming_key = generate_key
    end
    start_encrypt(incoming_phrase, incoming_key, incoming_date)
    { encryption: encrypted_message, date: @date, key: @key }
  end

  def start_encrypt(incoming_phrase, incoming_key, incoming_date)
      @message = incoming_phrase
      @key = incoming_key.rjust(5)
      @date = incoming_date.ljust(6)
  end

  def encrypt_index(current_index, turn)
    encrypt_index = current_index + total_shift[shifting_hash[turn]]
    encrypt_index = encrypt_index % @characters.count if encrypt_index >= @characters.count
    encrypt_index
  end

  def encrypted_message
    turn = 0
    encrypt_msg = message_array.map do |character|
      if !@characters.include?(character)
        character
      else
        current_index = @characters.find_index(character)
        new_character = @characters[encrypt_index(current_index, turn)]
        turn += 1 if turn < 4
        turn = 0 if turn == 4
        new_character
      end
    end
    @encryption = encrypt_msg.join
  end

def decrypt(incoming_phrase, incoming_key, incoming_date = generate_date)
    start_dencrypt(incoming_phrase, incoming_key, incoming_date)
    {decryption: dencrypted_message, date: @date, key: @key }
  end

  def start_dencrypt(incoming_phrase, incoming_key, incoming_date)
      @encryption = incoming_phrase
      @key = incoming_key.rjust(5)
      @date = incoming_date.ljust(6)
  end

  def dencrypt_index(current_index, turn)
    dencrypt_index = current_index - total_shift[shifting_hash[turn]]
    dencrypt_index = dencrypt_index % @characters.count if dencrypt_index <= @characters.count
    dencrypt_index
  end

  def dencrypted_message
    turn = 0
    dencrypt_msg = encryption_array.map do |character|
      if !@characters.include?(character)
        character
      else
        current_index = @characters.find_index(character)
        new_character = @characters[dencrypt_index(current_index, turn)]
        turn += 1 if turn < 4
        turn = 0 if turn == 4
        new_character
      end
    end
    @message = dencrypt_msg.join
  end
end
