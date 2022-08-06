require 'date'
class Enigma
  attr_reader :characters, :message, :key, :date

  def initialize
    @characters = ('a'..'z').to_a << ' '
    @message = ''
    @key = ''
    @date = ''
  end

  def start_encrypt(incoming_phrase, incoming_key, incoming_date)
    @message = incoming_phrase
    @key = incoming_key
    @date = incoming_date
  end

  def generate_key
   rand.to_s[2..6]
  end

  def generate_date
    Date.today.strftime('%d%m%y')
  end

  def encrypt(incoming_phrase, incoming_key = generate_key, incoming_date = generate_date)
    start_encrypt(incoming_phrase, incoming_key, incoming_date)
    { encryption: encrypt_message, date: @date, key: @key }
  end

  def key_shift
    { A: @key[0..1].to_i, B: @key[1..2].to_i, C: @key[2..3].to_i, D: @key[3..4].to_i }
  end

  def date_shift
    date_code = (@date.to_i**2).to_s[-4..-1]
    { A: date_code[0].to_i, B: date_code[1].to_i, C: date_code[2].to_i, D: date_code[3].to_i }
  end

  def total_shift
    key_shift.merge(date_shift) { |_offset, key_value, date_value| key_value + date_value }
  end

  def message_array
    @message.chars
  end

  def shifting_hash
    { 0 => :A, 1 => :B, 2 => :C, 3 => :D }
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
