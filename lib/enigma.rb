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
    @encryption = encrypt_message
    { encryption: encrypt_message, date: @date, key: @key }
  end

  def start_encrypt(incoming_phrase, incoming_key, incoming_date)
      @message = incoming_phrase
      @key = incoming_key.rjust(5)
      @date = incoming_date.rjust(6)
  end

  def generate_key
   rand.to_s[2..6]
  end

  def generate_date
    Date.today.strftime('%d%m%y')
  end

  def encrypt_index(current_index, turn)
    encrypt_index = current_index + total_shift[shifting_hash[turn]]
    encrypt_index = encrypt_index % @characters.count if encrypt_index >= @characters.count
    encrypt_index
  end

  def encrypt_message
    turn = 0
    message_array.map do |character|
      if !@characters.include?(character)
        character
      else
        current_index = @characters.find_index(character)
        new_character = @characters[encrypt_index(current_index, turn)]
        turn += 1 if turn < 4
        turn = 0 if turn == 4
        new_character
      end
    end.join
  end
end
