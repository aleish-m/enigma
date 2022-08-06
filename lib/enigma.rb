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

  def generated_key
    '99999'
  end

  def generated_date
    Date.today.strftime("%d%m%y")
  end

  def encrypt(incoming_phrase, incoming_key = generated_key, incoming_date = generated_date)
    start_encrypt(incoming_phrase, incoming_key, incoming_date)
    {encryption: shifted_message, date: @date, key: @key}
  end

  def key_shift
    { A: @key[0..1].to_i, B: @key[1..2].to_i, C: @key[2..3].to_i, D: @key[3..4].to_i }
  end

  def date_shift
    date_code = (@date.to_i**2).to_s[-4..-1]
    { A: date_code[0].to_i, B: date_code[1].to_i, C: date_code[2].to_i, D: date_code[3].to_i }
  end

  def total_shift
    key_shift.merge(date_shift) { |offset, key_value, date_value| key_value + date_value }
  end

  def message_array
    @message.chars
  end

  def shifting_hash
    {0 => :A, 1 => :B, 2 => :C, 3 => :D}
  end

  def encrypt_index(current_index, turn)
    encrypt_index = current_index + total_shift[shifting_hash[turn]] 
    if encrypt_index >= @characters.count
      encrypt_index = encrypt_index % @characters.count
    end
    encrypt_index
  end

  def shifted_message
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